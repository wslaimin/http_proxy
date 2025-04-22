package com.lm.http_proxy

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** HttpProxyPlugin */
class HttpProxyPlugin : FlutterPlugin, MethodCallHandler {
	/// The MethodChannel that will the communication between Flutter and native Android
	///
	/// This local reference serves to register the plugin with the Flutter Engine and unregister it
	/// when the Flutter Engine is detached from the Activity
	private lateinit var channel: MethodChannel

	override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.lm.http.proxy")
		channel.setMethodCallHandler(this)
	}

	override fun onMethodCall(call: MethodCall, result: Result) {
		when (call.method) {
			"getProxyHost" ->
				result.success(getProxyHost())

			"getProxyPort" ->
				result.success(getProxyPort())

			else -> result.notImplemented()
		}
	}

	override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
		channel.setMethodCallHandler(null)
	}

	private fun getProxyHost(): String? {
		return System.getProperty("http.proxyHost")
	}

	private fun getProxyPort(): String? {
		return System.getProperty("http.proxyPort")
	}
}
