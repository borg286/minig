#!/bin/bash
docker run -d -p 5000:5000 --restart=always --name registry  -v ~/cluster_data/registry_data:/var/lib/registry registry:2
