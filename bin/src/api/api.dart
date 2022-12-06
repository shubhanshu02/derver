import 'package:http/http.dart' as http;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert';
import 'dart:math';

class Api {
  Handler get handler {
    final router = Router();

    // Check for server
    router.get('/checkserver', (Request request) {
      return Response.ok('Server is running fine!');
    });
    // Author Name
    router.get('/author', author);
    // Author Name
    router.get('/greet', (Request request) {
      return Response.ok('Hi, there! Good Day!');
    });
    // For fetching and displaying random username
    router.get('/random', sampleUsers);

    return router as FutureOr<Response> Function(Request);
  }

  Future<Response> sampleUsers(Request request) async {
    // This API takes input from another API and forwards it to the user
    var random = Random();
    var randomId = random.nextInt(10);
    var response = await http
        .get(Uri.https('jsonplaceholder.typicode.com', 'users/$randomId'));
    return Response.ok(response.body,
        headers: {'Content-Type': 'application/json'});
  }

  Response author(Request request) {
    return Response.ok(
        json.encode({
          'First Name': 'Shubhanshu',
          'Last Name': 'Saxena',
          'GitHub': 'shubhanshu02',
          'email': 'shubhanshu.e01@gmail.com',
        }),
        headers: {'Content-Type': 'application/json'});
  }
}
