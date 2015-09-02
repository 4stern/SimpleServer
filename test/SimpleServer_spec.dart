library SimpleServer;

import 'dart:async';
import 'dart:io';
import 'package:SimpleServer/SimpleServer.dart';
import 'package:route_provider/route_provider.dart';

class RouteControllerError extends RouteController {
    RouteControllerError();

    Future<Map> execute(HttpRequest request, Map params) async  {
        throw new RouteError(HttpStatus.NOT_FOUND,"ERROR");
    }
}

class APIController extends RestApiController {
    Future<Map> onGet(HttpRequest request, Map params) async {
        throw new RouteError(HttpStatus.INTERNAL_SERVER_ERROR, 'Not supported');
    }
}

Future main() async {

    //start webserver
    SimpleServer server = new SimpleServer();
    await server.start();

    server.route(
        // url: "/",
        // controller: new EmptyRouteController(),
        responser: new FileResponse("docroot/home.html")
    )
    ..route(
        url: "/error",
        controller: new RouteControllerError(),
        responser: new FileResponse("docroot/home.html")
    )
    ..route(
        url: "/error2",
        controller: new APIController(),
        responser: new FileResponse("docroot/home.html")
    );

    //perform more tests here

    //close server
    server.stop();
}
