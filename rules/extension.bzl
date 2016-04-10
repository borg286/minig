def protogen_impl(name, langs, proto):
  cmd = ["cp 
  cmd += ["docker run -v `pwd`:/defs namely/protoc-" + x for x in  ctx.attr.langs]
  output = 
  native.genrule(
      name = name,
      cmd = "\n".join(cmd),
      srcs = ctx.files.deps,
      outs = [output],
      local = 1,
  )
  


def dependency_impl(ctx):
  content = ctx.attr.prefix + "\n"  
  content += "\n".join(ctx.attr.list)
  content += "\n".join(['"%s": "%s"' % (key, value) for key, value in ctx.attr.map.items()])
  content += "\n" + ctx.attr.postfix + "\n";
  ctx.file_action(output=ctx.outputs.out, content=content)

def dockerfile_impl(ctx):
  content = ["FROM " + ctx.attr.base]
  content += ["ADD " + x.short_path + " ." for x in ctx.files.deps]
  if ctx.attr.run:
    content += ["RUN " + ctx.attr.run];
  ctx.file_action(output=ctx.outputs.out, content="\n".join(content))


py_dockerfile = rule(
    implementation=dockerfile_impl,
    attrs={
        "base": attr.string(default="python"),
        "deps": attr.label_list(),
        "run": attr.string(default="pip install -r requirements.txt")
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
        "base": attr.string(default="node"),
        "deps": attr.label_list(),
        "map": attr.string_dict(),
        "run": attr.string(default="npm install")
    },
    outputs={"out": "%{name}/Dockerfile"}
)

node_package = rule(
    implementation=dependency_impl,
    attrs={
        "prefix": attr.string(default='{"name": "somename","version": "0.1.0","dependencies": {'),
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
      "docker build -t %s %s ." % (image_name, ' '.join(args)),
      "cd - >/dev/null",
      "touch $@",
    ]

  native.genrule(
      name = name,
      cmd = "\n".join(cmd),
      srcs = [src] + data + deps,
      outs = [done_marker],
      local = 1,
  )
