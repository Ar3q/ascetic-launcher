import 'package:ascetic_launcher/AppListItem.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AsceticLauncherPage extends StatefulWidget {
  AsceticLauncherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AsceticLauncherPageState createState() => _AsceticLauncherPageState();
}

class _AsceticLauncherPageState extends State<AsceticLauncherPage> {
  List<Application> apps = List<Application>();

  Future<void> getApplications() async {
    List<Application> appList = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
        onlyAppsWithLaunchIntent: true);

    setState(() {
      apps = appList;
    });
  }

  @override
  void initState() {
    super.initState();
    getApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Test'),
            Expanded(
              flex: 5,
              child: ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: apps.length,
                itemBuilder: (context, i) => listItemBuilder(context, i),
                separatorBuilder: (context, i) => Divider(),
              ),
            ),
            Text('Test'),
          ],
        ),
      ),
    );
  }

  Widget listItemBuilder(BuildContext context, int index) {
    return AppListItem(app: apps[index],);
  }
}
