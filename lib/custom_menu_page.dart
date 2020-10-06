import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_scaffold.dart';

class CustomMenuPage extends StatefulWidget {
  const CustomMenuPage({ Key key }) : super(key: key);

  static const String routeName = '/custom-menu';

  @override _CustomMenuPageState createState() => _CustomMenuPageState();
}

class _CustomMenuPageState extends State<CustomMenuPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Custom Menu Page',
      child: SelectableText(
        'Select me custom menu',
        /*
        textSelectionControls: DefaultTextSelectionControls(
          handle: CupertinoTextSelectionHandle(color: Colors.black),
          toolbar: toolbar(items),
        ),
        */
        textSelectionControls: cupertinoTextSelectionControls,
      ),
    );
  }
}
