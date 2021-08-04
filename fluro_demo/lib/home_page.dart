import 'package:fluro_demo/fluro/navigator_utils.dart';
import 'package:fluro_demo/fluro/routers.dart';
import 'package:fluro_demo/model/info_model.dart';
import 'package:fluro_demo/page/params_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fluro Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  NavigatorUtils.push(context, PageRouter.noParamPage);
                },
                child: Text("无参数")),
            TextButton(
                onPressed: () {
                  NavigatorUtils.push(
                      context, "${PageRouter.paramsPathPage}/口十耳");
                },
                child: Text("参数传递-(/:key1)")),
            TextButton(
                onPressed: () {
                  NavigatorUtils.push(
                      context, "${PageRouter.paramsPathPage}/口十耳/12");
                },
                child: Text("参数传递-(/:key1/:key2)")),
            TextButton(
                onPressed: () {
                  NavigatorUtils.push(context,
                      "${PageRouter.paramsPathPage}/口十耳/12/2021-08-04 12:12:12");
                },
                child: Text("参数传递-(/:key1/:key2/:key3)")),
            TextButton(
                onPressed: () {
                  NavigatorUtils.push(context, PageRouter.paramsQueryPage,
                      params: {
                        ParamsPage.k1: "口十耳",
                        ParamsPage.k3: 100,
                        ParamsPage.k2: DateTime.now(),
                      });
                },
                child: Text("参数传递-(?key=value)")),
            TextButton(
                onPressed: () {
                  NavigatorUtils.push(
                    context,
                    PageRouter.paramsObjectPage,
                    argument: InfoModel(
                      name: "JsonYe",
                      age: 100,
                      sex: true,
                    ),
                  );
                },
                child: Text("参数传递-Object")),
          ],
        ),
      ),
    );
  }
}
