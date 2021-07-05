package com.madpocket.webview_version

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.net.Uri
import android.os.Build
import android.util.Log
import android.webkit.WebView
import androidx.annotation.NonNull
import androidx.webkit.WebViewCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WebviewVersionPlugin */
class WebviewVersionPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "webview_version")
        context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getWebViewVersion") {
            result.success(WebViewCompat.getCurrentWebViewPackage(context)?.versionName)
        } else if (call.method == "getWebViewPackage") {
            result.success(WebViewCompat.getCurrentWebViewPackage(context)?.packageName)
        } else if (call.method == "startGooglePlay") {
            val argument = call.argument<String>("appPackageName")
            if(argument != null) {
                startGooglePlay(argument)
                result.success(null)
            } else {
                result.notImplemented()
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun startGooglePlay(appPackageName: String) {
        context.run {
            try {
                startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$appPackageName")).also {
                    it.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                })
            } catch (e: android.content.ActivityNotFoundException) {
                startActivity(
                    Intent(
                        Intent.ACTION_VIEW,
                        Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")
                    )
                )
            }
        }
    }
}
