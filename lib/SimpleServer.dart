library SimpleServer;

import 'dart:async';
import 'dart:io';
// import 'dart:convert';
import 'package:dart_config/default_server.dart';
import 'package:route_provider/route_provider.dart';

class SimpleServer {

    Map config;
    HttpServer server;
    int port;
    RouteProvider provider;
    bool readyToStart = false;

    SimpleServer();

    Future<bool> start() async {
        try {
            this.config = await loadConfig();
            if (this.config.containsKey('server')) {
                Map serverConfig = this.config['server'];
                if (serverConfig.containsKey('port')) {
                    this.port = int.parse(serverConfig["port"].toString());

                    this._init();
                    return true;
                } else {
                    throw new StateError('Config failed: missing port value');
                }
            } else {
                throw new StateError('Config failed: missing server part');
            }
        } catch (error) {
            if (error == "config.yaml does not exist") {
                print('Please create the config file to start the server.');
                print('Server stopped.');
            } else {
                print(error);
            }
            return false;
        }
    }

    Future stop() async {
        if (this.provider!=null) {
            this.provider.stop();
        }
    }

    Future _init() async {
        this.server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, this.port);
        print('listening on localhost, port ' + this.port.toString());

        this.provider = new RouteProvider(server, {"defaultRoute": "/", "staticContentRoot": "/docroot"});
    }

    SimpleServer route({
        String url: "/",
        RouteController controller,
        ResponseHandler responser
    }) {
        if (this.provider != null) {
            this.provider.route(
                url: url,
                controller: controller,
                responser: responser
            );
        }
        return this;
    }
}
