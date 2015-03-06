var http = require('http');

function start() {
	function onRequest(request, response){
		console.log('Request received.');
		response.writeHead(200, {'Content-Type': 'text/plain'});
		response.write('Hello World!\n');
		response.end();
	}
	http.createServer(onRequest).listen(8124);
	console.log('Server running at http://localhost:8124');
}

exports.start = start;

