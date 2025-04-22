import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_proxy/http_proxy_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelHttpProxy platform = MethodChannelHttpProxy();
  const MethodChannel channel = MethodChannel('com.lm.http.proxy');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getProxyPort', () async {
    expect(await platform.getProxyPort(), '42');
  });
}
