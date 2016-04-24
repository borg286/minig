http_archive(
    name = "protoc",
    url = "https://www.dropbox.com/s/nii6pnw11kkey6d/protoc_grpc.zip?dl=1",
    sha256 = "dbd1571dfe85103c928d98c1c9c1e1e6a345637948d26b1c21708e151acf66d9"
)

git_repository(
    name = "bazel",
    remote = "https://github.com/bazelbuild/bazel.git",
    tag = "0.2.1",
)
maven_jar(
    name = "guava",
    artifact = "com.google.guava:guava:18.0",
)
maven_jar(
    name = "grpc",
    artifact = "io.grpc:grpc-all:0.13.2",
)
http_jar(
    name = "grpc_sona",
    url = "https://oss.sonatype.org/content/repositories/snapshots/io/grpc/grpc-all/0.14.0-SNAPSHOT/grpc-all-0.14.0-20160309.215526-2.jar"
)
maven_jar(
    name = "protobuf",
    artifact = "com.google.protobuf:protobuf-java:3.0.0-beta-2",
)

