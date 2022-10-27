# http_proxy

http_proxy get the proxy settings of mobile device automatically,and set up proxy for [http](https://pub.dev/packages/http).

## Getting Started

You should initialize before runapp().

```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpProxy httpProxy = await HttpProxy.createHttpProxy();
  HttpOverrides.global=httpProxy;
  runApp(MyApp());
}
```

That's all done.You can use Charles or other proxy tools now.

⚠️ Plugin ignores all CA checks because http library does't use platform CA store.The suggestion that the plugin is available only in dev environment is security for https requests.