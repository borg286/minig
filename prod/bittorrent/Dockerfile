FROM ubuntu
ADD http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable /btsync.tar.gz
ADD btsync.conf /btsync
RUN tar -xf /btsync.tar.gz
RUN rm /btsync.tar.gz
RUN /btsync --dump-sample-config > /btsync.conf
RUN sed -i 's/\/\/  ,"directory_root"/,"directory_root"/g' /btsync.conf
EXPOSE 8888
EXPOSE 3000
CMD ["/btsync", "--config", "/btsync.conf", "--nodaemon"]

