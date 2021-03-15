import 'dart:io';
import 'package:args/args.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

const _hostname = 'localhost';

class MyServer {
  void init(port) async {
    final server = await shelf_io.serve(handler, _hostname, port);
    print('Server running on localhost:${server.port}');
  }

  Handler get handler {
    final router = Router();

    // Check for server
    router.get('/checkserver', (Request request) {
      return Response.ok('Hi! Server is running fine!');
    });

    // Handler for static files
    router.mount('/static/', createStaticHandler('static'));
    // Handler for HTML Files
    // TODO: Switch to template handling
    router.mount(
        '/', createStaticHandler('templates', defaultDocument: 'index.html'));

    return router;
  }
}

void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  // For Google Cloud Run, we respect the PORT environment variable
  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }
  final service = MyServer();
  service.init(port);
}
