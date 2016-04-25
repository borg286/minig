var PROTO_PATH = __dirname + '/emailer.proto';

var grpc = require('grpc');
var emailer_proto = grpc.load(PROTO_PATH).emailer;

/**
 * Implements the Email RPC method. 
 */
function email(call, callback) {
  callback(null, {id: 1});
}
function getStatus(call, callback) {
  callback(null, {status: "some status"})
}

/**
 * Starts an RPC server that receives requests for the Emailer service at the
 * sample server port
 */
function main() {
  var server = new grpc.Server();
  server.addProtoService(emailer_proto.Emailer.service, {
    email: email,
    getStatus: getStatus
  });
  server.bind('0.0.0.0:50051', grpc.ServerCredentials.createInsecure());
  console.log("Starting server");
  server.start();
}

main();
