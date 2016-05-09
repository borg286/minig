FROM ubuntu
RUN apt-get update
RUN apt-get install -y npm nodejs-legacy
ADD node/base/libgrpc_0.5.0_amd64.deb .
ADD node/base/libgrpc-dev_0.5.0_amd64.deb .
ADD node/base/node_modules.tar.gz .
RUN dpkg -i libgrpc_0.5.0_amd64.deb libgrpc-dev_0.5.0_amd64.deb
