load("/rules/extension", "docker_build")
load("/rules/extension", "node_dockerfile")
load("/rules/extension", "node_package")

filegroup(
  name = "mysrcs",
  srcs = [      
      "emailer.js",
      "emailer.proto",
      "node_modules.tar.gz"
  ]
)

node_dockerfile(
  name="emailer-dockerfile",
  base="localhost:5000/emailer-base",
  deps = [":mysrcs"]
)
docker_build(
  name = "docker-build-push",
  image_name = "localhost:5000/emailer",
  data = [":mysrcs"],
  src = ":emailer-dockerfile",
  deps = [":emailer-base"]
)

node_dockerfile(
  name = "dockerbasefile",
  deps=[":package_json"]
)
node_package(
  name = "package_json",
  map = {
    #"async": "^1.5.2"
    #"grpc": "0.12.0",
    #"lodash": "^4.6.1",
    #"minimist": "^1.2.0"
  }
)

docker_build(
  name = "emailer-base",
  src = ":dockerbasefile",
  data = [":package_json"],
  image_name = "localhost:5000/emailer-base"
)
