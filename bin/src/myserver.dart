import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'api/api.dart';

const _hostname = 'localhost';

class MyServer {
  void init(port) async {
    final server = await shelf_io.serve(handler, _hostname, port);
    print('Server running on localhost:${server.port}');
  }

  Handler get handler {
    final router = Router();

    // API Handler
    router.mount('/api/', Api().handler);
    // Handler for static files
    router.mount('/static/', createStaticHandler('static'));
    // Handler for HTML Files
    // TODO: Switch to template handling
    router.mount('/', createStaticHandler('templates', defaultDocument: 'index.html'));

    return router;
  }
}
