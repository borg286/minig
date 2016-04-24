var PROTO_PATH = __dirname + '/helloworld.proto';

var grpc = require('grpc');
var hello_proto = grpc.load(PROTO_PATH).helloworld;

function main() {
  var user,client;
  if (process.argv.length >= 3) {
    user = process.argv[2];
  } else {
    user = 'world';
  }

  if (process.argv.length >= 4) {
     var argv = require('minimist')(process.argv.slice(2))
     var target = process.env[argv['server'] + "_SERVICE_HOST"] + ":" + process.env[argv['server'] + "_SERVICE_PORT"];
     console.log("Saying hello");
     client = new hello_proto.Greeter(target, grpc.credentials.createInsecure());
  } else {
     client = new hello_proto.Greeter("172.17.0.5:50051",
                                       grpc.credentials.createInsecure());
  }

  client.sayHello({name: user}, function(err, response) {
    console.log('Greeting:', response.message);
  });
}

main();
