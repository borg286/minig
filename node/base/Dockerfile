FROM ubuntu
RUN apt-get update
RUN apt-get install -y npm nodejs-legacy
ADD libgrpc_0.5.0_amd64.deb .
ADD libgrpc-dev_0.5.0_amd64.deb .
RUN dpkg -i libgrpc_0.5.0_amd64.deb libgrpc-dev_0.5.0_amd64.deb
