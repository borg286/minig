FROM localhost:5000/nodegrpc-base
EXPOSE 50051
ADD myapp/greeter_server.js .
ADD myapp/greeter_client.js .
ADD myapp/helloworld.proto .
CMD ["node", "greeter_server.js"]
