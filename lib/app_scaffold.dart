import 'package:flutter/material.dart';
import 'settings_model.dart';

class AppScaffold extends StatelessWidget {
  AppScaffold({
    @required this.title,
    @required this.child,
  }) : assert(child != null),
       assert(title != null);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    final SettingsModel model = ModelBinding.of<SettingsModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          if (ModalRoute.of(context).settings.name != '/settings')
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              },
            ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          platform: model.platform,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
