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
      "route_guide_db.json",
      ":route_guide_proto",
  ]
)

node_dockerfile(
  name="route_guide-dockerfile",
  data = [":mysrcs"],
)
docker_build(
  name = "docker-build-push",
  image_name = 'localhost:5000/route_guide:$$(whoami)-$$(date "+%m%d%H%M")',
  data = [":mysrcs"],
  deps = ["//node/base:node"],
  src = ":route_guide-dockerfile",
)
