import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppListItem extends StatelessWidget {
  final app;

  const AppListItem({Key key, this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: GestureDetector(
        onTap: () {
          DeviceApps.openApp(app.packageName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Text(
                app.appName.toString(),
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
