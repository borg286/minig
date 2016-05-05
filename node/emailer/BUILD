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
      ":emailer_proto",
  ]
)

node_dockerfile(
  name="emailer-dockerfile",
  base="localhost:5000/emailer-base",
  deps = [":mysrcs"]
)
docker_build(
  name = "docker-build-push",
  image_name = 'localhost:5000/emailer:$$(whoami)-$$(date "+%m%d%H%M")',
  data = [":mysrcs"],
  src = ":emailer-dockerfile",
  deps = [":emailer-base"]
)

node_dockerfile(
  name = "dockerbasefile",
  deps=[":package_json", "node_modules.tar.gz"]
)
node_package(
  name = "package_json",
  map = {
  }
)

docker_build(
  name = "emailer-base",
  src = ":dockerbasefile",
  data = [":package_json", "node_modules.tar.gz"],
  image_name = "localhost:5000/emailer-base"
)
