import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_proxy/http_proxy.dart';

var proxyHost;
var proxyPort;
const url = 'https://api.github.com/users/wslaimin';

void main() async {
  if (kReleaseMode) {
    runApp(MyApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    HttpProxy httpProxy = await HttpProxy.createHttpProxy();

    proxyHost = httpProxy.host;
    proxyPort = httpProxy.port;

    HttpOverrides.global=httpProxy;
    runApp(MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _future;

  @override
  void initState() {
    super.initState();
    _future = get(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HTTP proxy example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'proxyHost:$proxyHost',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'proxyPort:$proxyPort',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'url:$url',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Divider(
              height: 30,
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<Response>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          snapshot.data?.body.toString() ?? 'null',
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
