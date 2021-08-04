import 'package:fluro/fluro.dart';
import 'package:fluro_demo/model/info_model.dart';
import 'package:fluro_demo/page/no_param_page.dart';
import 'package:fluro_demo/page/object_page.dart';
import 'package:flutter/material.dart';

import '../page/params_page.dart';

abstract class IRouter {
  void initFluroRouter(FluroRouter fluroRouter);
}

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
    //添加模块路由
    _mListRouter.add(PageRouter());

    _mListRouter.forEach((element) {
      element.initFluroRouter(router);
    });
  }
}

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
