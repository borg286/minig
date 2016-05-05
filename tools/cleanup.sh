#!/bin/bash
docker images | grep `whoami`- | awk '{print $1 ":" $2}' | xargs -I {} docker rmi {}
