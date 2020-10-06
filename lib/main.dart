import 'package:flutter/material.dart';
import 'app_scaffold.dart';
import 'default_page.dart';
import 'settings_page.dart';
import 'settings_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelBinding<SettingsModel>(
      initialModel: SettingsModel(),
      child: MaterialApp(
        title: 'Flutter Validation Sandbox',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: <String, Widget Function(BuildContext)>{
          '/': (BuildContext context) => MyHomePage(),
          DefaultPage.routeName: (BuildContext context) => DefaultPage(),
          '/settings': (BuildContext context) => SettingsPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Text Menu Customization',
      child: ListView(
        children: <Widget>[
          MyListItem(
            route: '/default',
            subtitle: 'The default behavior',
            title: 'Default',
          ),
        ],
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  MyListItem({
    Key key,
    this.route,
    this.subtitle,
    this.title,
  }) : super(key: key);

  final String route;
  final String subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        margin: EdgeInsets.all(12.0),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ),
      ),
    );
  }
}
