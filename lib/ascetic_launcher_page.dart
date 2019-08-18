import 'package:ascetic_launcher/clock.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import 'app_list_item.dart';

class AsceticLauncherPage extends StatefulWidget {
  AsceticLauncherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AsceticLauncherPageState createState() => _AsceticLauncherPageState();
}

class _AsceticLauncherPageState extends State<AsceticLauncherPage> {
  List<Application> _apps = List<Application>();

  Future<void> getApplications() async {
    List<Application> appList = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);

    appList.sort((a, b) => a.appName.compareTo(b.appName));

    setState(() {
      _apps = appList;
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Clock(),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _apps.length,
                  itemBuilder: (context, i) => listItemBuilder(context, i),
                  separatorBuilder: (context, i) => Divider(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItemBuilder(BuildContext context, int index) {
    return AppListItem(
      app: _apps[index],
    );
  }
}
