import 'package:flutter/material.dart';
import 'app_scaffold.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({ Key key }) : super(key: key);

  static const String routeName = '/default';

  @override _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  final TextEditingController controller = TextEditingController(
    text: 'Select me',
  );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Default Page',
      child: TextField(
        controller: controller,
      ),
      /*
      child: SelectableText(
        'Select me',
      ),
      */
    );
  }
}
