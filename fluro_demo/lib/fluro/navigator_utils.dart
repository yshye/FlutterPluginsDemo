import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'routers.dart';

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
