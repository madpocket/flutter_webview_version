import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_version/webview_version.dart';

void main() {
  const MethodChannel channel = MethodChannel('webview_version');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == "getWebViewVersion") {
        return '42';
      } else if (methodCall.method == "getWebViewPackage") {
        return 'com.google.android.webview';
      }
      return "undefined";
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getWebViewVersion', () async {
    expect(await WebviewVersion.getWebviewVersion, '42');
  });

  test('getWebViewPackage', () async {
    expect(
        await WebviewVersion.getWebViewPackage, 'com.google.android.webview');
  });
}
