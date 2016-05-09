load("/rules/extension", "docker_build")
package(default_visibility = ["//visibility:public"])

filegroup(
  name = "mysrcs",
  srcs = [          
     "libgrpc_0.5.0_amd64.deb",
     "libgrpc-dev_0.5.0_amd64.deb",
     "node_modules.tar.gz"
  ]
)

docker_build(
  name = "node",
  src = "Dockerfile",
  data = [":mysrcs"],
  image_name = "localhost:5000/node",
)
