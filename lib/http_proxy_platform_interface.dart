import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'http_proxy_method_channel.dart';

abstract class HttpProxyPlatform extends PlatformInterface {
  /// Constructs a HttpProxyPlatform.
  HttpProxyPlatform() : super(token: _token);

  static final Object _token = Object();

  static HttpProxyPlatform _instance = MethodChannelHttpProxy();

  /// The default instance of [HttpProxyPlatform] to use.
  ///
  /// Defaults to [MethodChannelHttpProxy].
  static HttpProxyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HttpProxyPlatform] when
  /// they register themselves.
  static set instance(HttpProxyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getProxyHost() async {
    throw UnimplementedError('getProxyHost() has not been implemented.');
  }

  Future<String?> getProxyPort() async {
    throw UnimplementedError('getProxyPort() has not been implemented.');
  }
}
