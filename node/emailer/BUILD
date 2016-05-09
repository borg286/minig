load("/rules/extension", "docker_build")
load("/rules/extension", "node_dockerfile")
load("/rules/extension", "node_package")

filegroup(
  name = "emailer_proto",
  srcs = ["emailer.proto"]
)

filegroup(
  name = "mysrcs",
  srcs = [      
      "emailer.js",
      "emailer-client.js",
      ":emailer_proto",
  ]
)

node_dockerfile(
  name="emailer-dockerfile",
  deps = [":mysrcs"]
)
docker_build(
  name = "docker-build-push",
  image_name = 'localhost:5000/emailer:$$(whoami)-$$(date "+%m%d%H%M")',
  data = [":mysrcs"],
  src = ":emailer-dockerfile",
)
