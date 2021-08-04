import 'package:flutter/material.dart';

class ParamsPage extends StatefulWidget {
  static final String k1 = "k1";
  static final String k2 = "k2";
  static final String k3 = "k3";

  final String? p1;
  final String? p2;
  final String? p3;

  const ParamsPage({Key? key, this.p1, this.p2, this.p3}) : super(key: key);

  @override
  _ParamsPageState createState() => _ParamsPageState();
}

class _ParamsPageState extends State<ParamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginPage"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.p1 ?? ''),
            Text(widget.p2 ?? ''),
            Text(widget.p3 ?? ''),
          ],
        ),
      ),
    );
  }
}
