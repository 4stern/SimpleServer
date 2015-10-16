# SimpleServer

## Installation

Add it to your dependencies
```
dependencies:
  simple_server: any
```

and install the package
```
$ pub get
```

## Usage
```javascript
import 'dart:io';
import 'package:simple_server/simple_server.dart';
main() async {
    server = new SimpleServer("/", "/docroot");
    bool serverStarted = await server.start();

    if (serverStarted == true) {
        /* Web pages */
        server.route(url: "/",      responser: new FileResponse("docroot/index.html"))
        ..go();
    }
}
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

Robert Beyer <4sternrb@googlemail.com>

## License

MIT
