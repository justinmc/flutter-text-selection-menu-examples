import 'package:flutter/material.dart';
import 'settings_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key key }) : super(key: key);

  static const String routeName = '/default';

  @override _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final SettingsModel model = ModelBinding.of<SettingsModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
        actions: <Widget>[
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text('Force Android platform'),
                  Switch(
                    value: model.platform == TargetPlatform.android,
                    onChanged: (bool value) {
                      final TargetPlatform platform = value
                          ? TargetPlatform.android
                          : null;
                      ModelBinding.update<SettingsModel>(context, SettingsModel(
                        platform: platform,
                      ));
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('Force iOS platform'),
                  Switch(
                    value: model.platform == TargetPlatform.iOS,
                    onChanged: (bool value) {
                      final TargetPlatform platform = value
                          ? TargetPlatform.iOS
                          : null;
                      ModelBinding.update<SettingsModel>(context, SettingsModel(
                        platform: platform,
                      ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
