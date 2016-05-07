#!/bin/bash
bazel build docker-build-push && \
TAG=`docker images | awk '$1~/localhost:5000\/route_guide$/{print $2}' | grep \`whoami\` | sort -r | head -n 1` && \
sed -i "s/image: localhost:5000\/route_guide.*/image: localhost:5000\/route_guide:$TAG/" route_guide.yaml && \
sed -i "s/build: .*/build: $TAG/" route_guide.yaml && \
sed -i "s/image: localhost:5000\/route_guide.*/image: localhost:5000\/route_guide:$TAG/" route_guide_client.yaml && \
sed -i "s/build: .*/build: $TAG/" route_guide_client.yaml && \
#kubectl delete -f route_guide.yaml && \
#kubectl create -f route_guide.yaml && \
kubectl delete -f route_guide_client.yaml && \
kubectl create -f route_guide_client.yaml
