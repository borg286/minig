#!/bin/bash
bazel build docker-build-push
TAG=`docker images | awk '$1~/localhost:5000\/emailer$/{print $2}' | grep \`whoami\` | sort -r | head -n 1`
sed -i "s/image: localhost:5000\/emailer.*/image: localhost:5000\/emailer:$TAG/" emailer.yaml
sed -i "s/build: .*/build: $TAG/" emailer.yaml
kubectl apply -f emailer.yaml
