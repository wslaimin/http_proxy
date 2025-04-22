import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_user_certificates_android/flutter_user_certificates_android.dart';
import 'package:http_proxy/http_proxy_platform_interface.dart'
    show HttpProxyPlatform;

class HttpProxy extends HttpOverrides {
  String? host;
  String? port;
  Map<String, DERCertificate>? certs = {};

  HttpProxy._(this.host, this.port, {this.certs});

  static Future<HttpProxy> createHttpProxy() async {
    Map<String, DERCertificate>? certs;
    if (Platform.isAndroid) {
      certs = await FlutterUserCertificatesAndroid().getUserCertificates();
    }

    return HttpProxy._(await HttpProxyPlatform.instance.getProxyHost(),
        await HttpProxyPlatform.instance.getProxyPort(),
        certs: certs);
  }

  @override
  HttpClient createHttpClient(SecurityContext? passedContext) {
    var context = passedContext;

    if (Platform.isAndroid) {
      if (certs != null) {
        context ??= SecurityContext.defaultContext;
        for (DERCertificate cert in certs!.values) {
          context.setTrustedCertificatesBytes(cert.toPEM().bytes);
        }
      }
    }

    return super.createHttpClient(context);
  }

  @override
  String findProxyFromEnvironment(Uri url, Map<String, String>? environment) {
    if (host == null) {
      return super.findProxyFromEnvironment(url, environment);
    }

    if (environment == null) {
      environment = {};
    }

    if (port != null) {
      environment['http_proxy'] = '$host:$port';
      environment['https_proxy'] = '$host:$port';
    }

    return super.findProxyFromEnvironment(url, environment);
  }
}
