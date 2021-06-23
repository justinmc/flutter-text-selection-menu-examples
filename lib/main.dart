import 'package:flutter/material.dart';
import 'app_scaffold.dart';
import 'default_page.dart';
import 'settings_page.dart';
import 'settings_model.dart';
import 'custom_menu_page.dart';
import 'custom_cupertino_menu_page.dart';

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
          CustomMenuPage.routeName: (BuildContext context) => CustomMenuPage(),
          CustomCupertinoMenuPage.routeName: (BuildContext context) => CustomCupertinoMenuPage(),
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
            route: DefaultPage.routeName,
            subtitle: 'The default behavior',
            title: 'Default',
          ),
          MyListItem(
            route: CustomMenuPage.routeName,
            subtitle: 'Material-style custom menu and items',
            title: 'Custom Menu',
          ),
          MyListItem(
            route: CustomCupertinoMenuPage.routeName,
            subtitle: 'Cupertino-style custom menu and items',
            title: 'Custom Cupertino Menu',
          ),
        ],
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  const MyListItem({
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
