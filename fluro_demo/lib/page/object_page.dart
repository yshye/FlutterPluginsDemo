import 'package:fluro_demo/model/info_model.dart';
import 'package:flutter/material.dart';

class ObjectPage extends StatefulWidget {
  final InfoModel? userInfo;

  const ObjectPage({Key? key, this.userInfo}) : super(key: key);

  @override
  _ObjectPageState createState() => _ObjectPageState();
}

class _ObjectPageState extends State<ObjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserInfoPage'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(widget.userInfo?.toString() ?? '无'),
      ),
    );
  }
}
