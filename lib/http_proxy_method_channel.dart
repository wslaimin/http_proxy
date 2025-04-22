import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'http_proxy_platform_interface.dart';

/// An implementation of [HttpProxyPlatform] that uses method channels.
class MethodChannelHttpProxy extends HttpProxyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.lm.http.proxy');

  @override
  getProxyHost() async {
    final String? host = await methodChannel.invokeMethod('getProxyHost');
    return host;
  }

  @override
  getProxyPort() async {
    final String? port = await methodChannel.invokeMethod('getProxyPort');
    return port;
  }
}
