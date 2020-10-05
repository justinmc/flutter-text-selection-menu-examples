import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({ Key key }) : super(key: key);

  static const String routeName = '/default';

  @override _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Page'),
        actions: <Widget>[
        ],
      ),
      body: Center(
        child: TextField(
        ),
      ),
    );
  }
}
