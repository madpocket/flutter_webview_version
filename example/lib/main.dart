import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:webview_version/webview_version.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _webviewVersion = 'Unknown';
  String? _version = "";
  String? _name = "";

  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) {
      initWebviewVersion();
    }
  }

  Future<void> initWebviewVersion() async {
    String webviewVersion;
    try {
      _version = await WebviewVersion.getWebviewVersion;
      _name = await WebviewVersion.getWebViewPackage;
      webviewVersion = "$_name:$_version";
    } on PlatformException {
      webviewVersion = 'Failed to get webview version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _webviewVersion = webviewVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Running on: $_webviewVersion\n'),
              OutlinedButton(
                onPressed: () {
                  final package = _name;
                  if(package != null) {
                    WebviewVersion.startGooglePlay(package);
                  }
                },
                child: Text('Open Google Play'),
              ),
            ],
          )
            ,
        ),
      ),
    );
  }
}
