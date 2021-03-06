



def dependency_impl(ctx):
  content = ctx.attr.prefix + "\n"  
  content += "\n".join(ctx.attr.list)
  content += ",\n".join(['"%s": "%s"' % (key, value) for key, value in ctx.attr.map.items()])
  content += "\n" + ctx.attr.postfix + "\n";
  ctx.file_action(output=ctx.outputs.out, content=content)

def dockerfile_impl(ctx):
  content = ["FROM " + ctx.attr.base]
  content += ["ADD " + x.short_path + " ." for x in ctx.files.data]
  if ctx.attr.run_list:
    content += ["RUN " + x for x in ctx.attr.run_list];
  ctx.file_action(output=ctx.outputs.out, content="\n".join(content))


py_dockerfile = rule(
    implementation=dockerfile_impl,
    attrs={
        "base": attr.string(default="python"),
        "data": attr.label_list(),
        "run_list": attr.string_list(default=["pip install -r requirements.txt"])
    },
    outputs={"out": "%{name}/Dockerfile"}
)

py_requirements = rule(
    implementation=dependency_impl,
    attrs={
        "prefix": attr.string(default=""),
        "list": attr.string_list(),
        "map": attr.string_dict(),
        "postfix": attr.string(default="")
    },
    outputs={"out": "%{name}/requirements.txt"}
)

node_dockerfile = rule(
    implementation=dockerfile_impl,
    attrs={
        "base": attr.string(default="localhost:5000/node"),
        "deps": attr.label(default=Label("//node/base:node")),
        "data": attr.label_list(allow_files=True),
        "map": attr.string_dict(),
        "run_list": attr.string_list(default=["npm install"])
    },
    outputs={"out": "%{name}/Dockerfile"}
)

node_package = rule(
    implementation=dependency_impl,
    attrs={
        "prefix": attr.string(default='{"dependencies": {'),
        "list": attr.string_list(),
        "map": attr.string_dict(),
        "postfix": attr.string(default="}}")
    },
    outputs={"out": "%{name}/package.json"}
)

def docker_build(name, image_name,
                 src="Dockerfile",
                 deps=[],
                 data=[],
                 use_cache=True):
  done_marker = name + '.done'

  data_locs = []
  for d in data:
    data_locs += ['$(locations ' + d + ')']

  args = []
  if not use_cache:
    args += ['--force-rm', '--no-cache']
  cmd = [
      "set +u",
      "CTX=$@.ctx",
      'date && echo "copying files"',
      'rm -rf "$$CTX"',
      'mkdir "$$CTX"',
      "srcs=(%s)" % (" ".join(data_locs)),
      'echo $$srcs',
      "for src in $${srcs[@]}; do",
      "  dir=$$(dirname $$src)",
      '  if [[ $$dir == bazel-out/* ]]; then',
      "    dir=$${dir#*/*/*/}",
      "  fi",
      '  mkdir -p "$$CTX/$$dir"',
      '  cp -L --preserve=all $$src "$$CTX/$$dir"',
      '  echo copied $$src to "$$CTX/$$dir"',
      "done",
      "cp $(location %s) \"$$CTX\"" % (src),
      'cd "$$CTX"',
      'echo $$PWD',
      'date && echo "building"',
      "TAG=%s" % (image_name),
      "docker build -t $$TAG %s ." % (' '.join(args)),
      'date && echo "pushing to repo"',
      "docker push $$TAG",
      "cd - >/dev/null",
      "touch $@",
    ]

  native.genrule(
      name = name,
      cmd = "\n".join(cmd),
      srcs = [src] + data + deps,
      outs = [done_marker],
      tags = ["local", "requires-network"]
  )
