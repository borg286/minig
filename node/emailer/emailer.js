var PROTO_PATH = __dirname + '/emailer.proto';
 
var grpc = require('grpc');
var emailer_proto = grpc.load(PROTO_PATH).emailer;
var redis_server = require("redis"),
    redis = redis_server.createClient('redis://ledis', {prefix: "em"});


redis.on("error", function (err) {
    console.log("Error " + err);
});

/**
 * Implements the Email RPC method. 
 */
function email(call, callback) {
  var id = redis.incr("id");
  redis.set(id, call.recipient + call.body, redis_server.print);
  callback(null, {id: 1});
}

function getStatus(call, callback) {
  redis.get(call.id, function(err, reply) {
    callback(null, {status: reply})
  })
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
