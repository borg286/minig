load("/rules/extension", "py_dockerfile")
load("/rules/extension", "py_requirements")
load("/rules/extension", "node_dockerfile")
load("/rules/extension", "node_package")
load("/rules/extension", "docker_build")




py_requirements(
    name="myrequirements",
    list=[
        "grab==0.6.25"
    ]
)
py_dockerfile(name="mypybuild", deps=[":myrequirements"])
docker_build(
    name="mypydockerbase",
    src=":mypybuild",
    data=[":myrequirements"],
    image_name="mypybase"
)

node_package(
    name="mypackage",
    map={
        "minimist": "^1.2.0"
    }
)
node_dockerfile(name="mynodebuild", deps=[":mypackage"])
docker_build(
    name="mynodedockerbase",
    src=":mynodebuild",
    data=[":mypackage"],
    image_name="mynodebase"
)

