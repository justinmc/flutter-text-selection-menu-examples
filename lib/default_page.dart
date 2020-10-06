import 'package:flutter/material.dart';
import 'settings_model.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({ Key key }) : super(key: key);

  static const String routeName = '/default';

  @override _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    final SettingsModel model = ModelBinding.of<SettingsModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Page'),
        actions: <Widget>[
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          platform: model.platform,
        ),
        child: Center(
          child: TextField(
          ),
        ),
      ),
    );
  }
}
