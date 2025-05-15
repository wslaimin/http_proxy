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