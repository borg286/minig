var PROTO_PATH = __dirname + '/emailer.proto';
 
var grpc = require('grpc');
var emailer = grpc.load(PROTO_PATH).emailer;


/**
 * Starts an RPC server that receives requests for the Emailer service at the
 * sample server port
 */
function main() {
  console.log("connecting to emailer-svc");
  client = new emailer.Emailer("emailer-svc:50051", grpc.credentials.createInsecure());
  console.log("sending email");
  client.email({recipient: "borg286@gmail.com", subject: "hi brian", body: "you are my bro"},
    function(err, response) {
    console.log("Error: " + err);
    console.log('Email ID:', response.id);
  });
}

main();
