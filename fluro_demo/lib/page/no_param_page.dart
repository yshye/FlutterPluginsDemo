import 'package:flutter/material.dart';

class NoParamPage extends StatefulWidget {

  const NoParamPage({Key? key}) : super(key: key);

  @override
  _NoParamPageState createState() => _NoParamPageState();
}

class _NoParamPageState extends State<NoParamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoParamPage'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('NoParamPage'),
      ),
    );
  }
}
