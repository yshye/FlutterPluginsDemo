# Fluro 使用介绍

`Fluro` 是一款优秀的 Flutter 路由框架。

## 使用
### 1、pubspec.yaml中添加引用
```xml
fluro: ^2.0.3
```
执行命令：
```shell
flutter pub get
```
### 2、定义模块路由注册
```dart
abstract class IRouter {
  void initFluroRouter(FluroRouter fluroRouter);
}
```

### 3、基本配置
```dart
class BaseRouter {
  static FluroRouter? _mFluroRouter;

  static FluroRouter? getRouter() {
    return _mFluroRouter;
  }

  static void setRouter(FluroRouter router) {
    _mFluroRouter = router;
  }

  static List<IRouter> _mListRouter = [];
  static void registerConfigureRoutes(FluroRouter? router) {
    if (router == null) {
      throw Exception("fluroRouter is null, please init router");
    }

    router.notFoundHandler = Handler(
      handlerFunc:
          (BuildContext? context, Map<String, List<String>> parameters) {
        print("页面没有注册，找不到该页面  ");
      },
    );

    _mListRouter.clear();
    //添加路由配置
    _mListRouter.add(PageRouter());

    _mListRouter.forEach((element) {
      element.initFluroRouter(router);
    });
  }
}

```

### 4、模块路由配置
```dart
class PageRouter extends IRouter {
  static String noParamPage = "page/null";
  static String paramsPathPage = "page/params/path";
  static String paramsQueryPage = "page/params/query";
  static String paramsObjectPage = "page/params/object";

  @override
  void initFluroRouter(FluroRouter fluroRouter) {
    fluroRouter.define(noParamPage,
        handler: Handler(handlerFunc: (_, __) => NoParamPage()));

    fluroRouter.define("$paramsPathPage/:k1",
        handler: Handler(handlerFunc: (_, params) {
      String? p1 = params[ParamsPage.k1]?.first;
      return ParamsPage(p1: p1);
    }));

    fluroRouter.define("$paramsPathPage/:k1/:k2",
        handler: Handler(handlerFunc: (_, params) {
      String? p1 = params[ParamsPage.k1]?.first;
      String? p2 = params[ParamsPage.k2]?.first;
      return ParamsPage(p1: p1, p2: p2);
    }));

    fluroRouter.define("$paramsPathPage/:k1/:k2/:k3",
        handler: Handler(handlerFunc: (_, params) {
      String? p1 = params[ParamsPage.k1]?.first;
      String? p2 = params[ParamsPage.k2]?.first;
      String? p3 = params[ParamsPage.k3]?.first;
      return ParamsPage(p1: p1, p2: p2, p3: p3);
    }));

    fluroRouter.define(paramsQueryPage, handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      String? p1 = params[ParamsPage.k1]?.first;
      String? p2 = params[ParamsPage.k2]?.first;
      String? p3 = params[ParamsPage.k3]?.first;
      return ParamsPage(p1: p1, p2: p2, p3: p3);
    }));

    // 对象参数
    fluroRouter.define(paramsObjectPage, handler: Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>> parameters) {
      var model = context?.settings?.arguments;
      if (model != null && model is InfoModel) {
        return ObjectPage(userInfo: model);
      }
      return ObjectPage();
    }));
  }
}
```
### 5、统一跳转控制
```dart
class NavigatorUtils {
  static Future<dynamic> push(
    BuildContext context,
    String path, {
    Map<String, Object>? params,
    Object? argument,
    bool replace = false,
    bool clearStack = false,
  }) async {
    FocusScope.of(context).unfocus();
    if (params?.isNotEmpty ?? false) {
      return push(context, _params2Path(path, params: params),
          replace: replace, clearStack: clearStack);
    }

    return await BaseRouter.getRouter()
        ?.navigateTo(context, path,
            routeSettings:
                argument == null ? null : RouteSettings(arguments: argument),
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .catchError((onError) {
      print("$onError");
    });
  }

  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  static String _params2Path(String path, {Map<String, Object>? params}) {
    if (params == null || params.isEmpty) {
      return path;
    }
    StringBuffer bufferStr = StringBuffer();

    params.forEach((key, value) {
      bufferStr
        ..write("&")
        ..write(key)
        ..write('=')
        ..write(Uri.encodeComponent(value.toString()));
    });
    return "$path?${bufferStr.toString().substring(1)}";
  }
}
```
### 6、路由跳转
```dart
// 无参数
NavigatorUtils.push(context, PageRouter.noParamPage);
// 一个参数（path）
NavigatorUtils.push(context, "${PageRouter.paramsPathPage}/口十耳");
// 多个参数（path）
NavigatorUtils.push(context, "${PageRouter.paramsPathPage}/口十耳/12/2021-08-04 12:12:12");
// 多参数（key=value）
NavigatorUtils.push(context, PageRouter.paramsQueryPage,
                      params: {
                        ParamsPage.k1: "口十耳",
                        ParamsPage.k3: 12,
                        ParamsPage.k2: DateTime.now(),
                      });
// 复杂对象入参
NavigatorUtils.push(
    context,
    PageRouter.paramsObjectPage,
    argument: InfoModel(
      name: "JsonYe",
      age: 100,
      sex: true,
    ),
);

```


### 7、获取参数
#### 7.1 路径获取方式
```dart
fluroRouter.define("$paramsPathPage/:k1/:k2/:k3",
        handler: Handler(handlerFunc: (_, params) {
      String? p1 = params[ParamsPage.k1]?.first;
      String? p2 = params[ParamsPage.k2]?.first;
      String? p3 = params[ParamsPage.k3]?.first;
      return ParamsPage(p1: p1, p2: p2, p3: p3);
    }));
```
这样传递的参数只能是字符串格式，如果字符串中包含中文就需要使用Uri.encodeComponent进行转义

#### 7.2、键-值 对方式
```dart
fluroRouter.define(paramsQueryPage, handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      String? p1 = params[ParamsPage.k1]?.first;
      String? p2 = params[ParamsPage.k2]?.first;
      String? p3 = params[ParamsPage.k3]?.first;
      return ParamsPage(p1: p1, p2: p2, p3: p3);
    }));
```
 
 #### 7.3、复杂对象 方式
 ```dart
 fluroRouter.define(paramsObjectPage, handler: Handler(handlerFunc:
    (BuildContext? context, Map<String, List<String>> parameters) {
  var model = context?.settings?.arguments;
  if (model != null && model is InfoModel) {
    return ObjectPage(userInfo: model);
  }
  return ObjectPage();
}));
 ```

### 8、配置使用
通常在`main.dart`文件中，
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 定义路由
    final router = FluroRouter();
    // 配置路由（初始化）
    BaseRouter.registerConfigureRoutes(router);
    // 指定路由对象以便调用
    BaseRouter.setRouter(router);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      // 设置路由
      onGenerateRoute: BaseRouter.getRouter()?.generator,
    );
  }
}
```