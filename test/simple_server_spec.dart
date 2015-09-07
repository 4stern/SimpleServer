library simple_server;

import 'dart:async';
import 'dart:io';
import 'package:simple_server/simple_server.dart';
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

class ExitController extends RestApiController {
    SimpleServer server;

    ExitController(this.server);

    Future<Map> onGet(HttpRequest request, Map params) async {
        this.server.stop();
        return new Map();
    }
}

Future main() async {

    //start webserver
    SimpleServer server = new SimpleServer("/", "/docroot");
    bool serverStarted = await server.start();

    if (serverStarted == true) {
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
        )
        ..route(
            url: "/exit",
            controller: new ExitController(server),
            responser: new FileResponse("docroot/home.html")
        )
        ..go();

        //perform more tests here

        //close server
        server.stop();
    }
}
