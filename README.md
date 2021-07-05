# webview_version

This plugin allows Flutter Android apps to detect currently running webview package & version. In addition it exposes a method to open Google Play Store.

[![pub package](https://img.shields.io/pub/v/webview_version.svg)](https://pub.dev/packages/webview_version)

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✔️    | -️  |  -️   | -️  |  -️   |   -️    |

## Usage

Sample usage to check current status:

```dart
import 'package:webview_version/webview_version.dart';

String webviewVersion;
try {
_version = await WebviewVersion.getWebviewVersion;
_name = await WebviewVersion.getWebViewPackage;
webviewVersion = "$_name:$_version";
} on PlatformException {
webviewVersion = 'Failed to get webview version.';
}
```