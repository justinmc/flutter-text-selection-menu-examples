import 'package:flutter/material.dart';
import 'app_scaffold.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({ Key key }) : super(key: key);

  static const String routeName = '/default';

  @override _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Default Page',
      child: TextField(
      ),
    );
  }
}
