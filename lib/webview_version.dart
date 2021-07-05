import 'dart:async';

import 'package:flutter/services.dart';

class WebviewVersion {
  static const MethodChannel _channel = const MethodChannel('webview_version');

  static Future<String?> get getWebviewVersion async {
    final String? version = await _channel.invokeMethod('getWebViewVersion');
    return version;
  }

  static Future<String?> get getWebViewPackage async {
    final String? version = await _channel.invokeMethod('getWebViewPackage');
    return version;
  }

  static Future<void> startGooglePlay(String appPackageName) async {
    await _channel
        .invokeMethod('startGooglePlay', {"appPackageName": appPackageName});
  }
}
