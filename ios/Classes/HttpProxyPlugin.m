#import "HttpProxyPlugin.h"

@implementation HttpProxyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.lm.http.proxy"
            binaryMessenger:[registrar messenger]];
  HttpProxyPlugin* instance = [[HttpProxyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getProxyHost" isEqualToString:call.method]) {
      CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
      NSDictionary *dictProxy = (__bridge_transfer id)proxySettings;
      //是否开启了http代理
      if ([[dictProxy objectForKey:@"HTTPEnable"] boolValue]) {
          NSString *proxyHost = [dictProxy objectForKey:@"HTTPProxy"];
          result(proxyHost);
      }else{
        result(nil);
      }
    } else if ([@"getProxyPort" isEqualToString:call.method]) {
      CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
      NSDictionary *dictProxy = (__bridge_transfer id)proxySettings;
      //是否开启了http代理
      if ([[dictProxy objectForKey:@"HTTPEnable"] boolValue]) {
          NSString *proxyPort = [NSString stringWithFormat: @"%ld", [[dictProxy objectForKey:@"HTTPPort"] integerValue]];
          result(proxyPort);
      }else{
        result(nil);
      }
    }else{
      result(FlutterMethodNotImplemented);
    }
}

@end
