load("/rules/extension", "docker_build")
load("/rules/extension", "node_dockerfile")
load("/rules/extension", "node_package")

filegroup(
  name = "route_guide_proto",
  srcs = ["route_guide.proto"]
)

filegroup(
  name = "mysrcs",
  srcs = [      
      "route_guide_server.js",
      "route_guide_client.js",
      ":route_guide_proto",
  ]
)

node_dockerfile(
  name="route_guide-dockerfile",
  base="localhost:5000/route_guide-base",
  deps = [":mysrcs"]
)
docker_build(
  name = "docker-build-push",
  image_name = 'localhost:5000/route_guide:$$(whoami)-$$(date "+%m%d%H%M")',
  data = [":mysrcs"],
  src = ":route_guide-dockerfile",
  deps = [":route_guide-base"]
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
  name = "route_guide-base",
  src = ":dockerbasefile",
  data = [":package_json", "node_modules.tar.gz"],
  image_name = "localhost:5000/route_guide-base"
)
