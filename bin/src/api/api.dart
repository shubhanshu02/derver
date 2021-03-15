import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class Api {
  Handler get handler {
    final router = Router();

    // Check for server
    router.get('/checkserver', (Request request) {
      return Response.ok('Server is running fine!');
    });

    router.get('/__author', author);

    // For messages
    router.get('/messages', _messages);
    router.get('/messages/', _messages);

    return router;
  }

  Future<Response> _messages(Request request) async {
    return Response.ok('[]');
  }

  Response author(Request request) {
    return Response.ok(
        'Hi! This server is written by Shubhanshu Saxena. Find me @shubhanshu02 on GitHub');
  }
}
