load("/rules/extension", "docker_build")
load("/rules/extension", "node_dockerfile")
load("/rules/extension", "node_package")

filegroup(
  name = "mysrcs",
  srcs = [      
      "greeter_server.js",
      "greeter_client.js",
      "helloworld.proto"
  ]
)

node_dockerfile(
  name="mydockerfile",
  base="localhost:5000/nodegrpc-base",
  deps = [":mysrcs"]
)
docker_build(
  name = "myimage",
  image_name = "localhost:5000/mynodegrpc",
  data = [":mysrcs"],
  deps = [":nodegrpc-base"]
)

node_dockerfile(
  name = "mydockerbasefile",
  deps=[":mypackage_json"]
)
node_package(
  name = "mypackage_json",
  map = {
    "async": "^1.5.2",
    "grpc": "0.13.0",
    "lodash": "^4.6.1",
    "minimist": "^1.2.0"
  }
)

docker_build(
  name = "nodegrpc-base",
  src = ":mydockerbasefile",
  data = [":mypackage_json"],
  image_name = "localhost:5000/nodegrpc-base"
)
