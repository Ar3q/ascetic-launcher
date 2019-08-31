import 'package:ascetic_launcher/all_apps_page.dart';
import 'package:ascetic_launcher/clock.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'apps_list.dart';

const key = 'favofite_apps';

class AsceticLauncherPage extends StatefulWidget {
  AsceticLauncherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AsceticLauncherPageState createState() => _AsceticLauncherPageState();
}

class _AsceticLauncherPageState extends State<AsceticLauncherPage> {
  List<Application> _apps = List<Application>();
  List<Application> favoriteApps = List<Application>();

  bool isShowingAllApps = false;

  getAllApplications() async {
    List<Application> appList = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);

    appList.sort((a, b) => a.appName.compareTo(b.appName));

    setState(() {
      _apps = appList;
    });
  }

  fetchFavoriteAppsFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favAppsStringList = prefs.getStringList(key) ?? [];

    print('lenght ' + favAppsStringList.length.toString());

    List<Application> favApps = await convertToListOfApps(favAppsStringList);

    setState(() {
      favoriteApps = favApps;
    });
  }

  saveFavoriteAppsToSharedPrefs(List<String> newFavoriteAppsList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, newFavoriteAppsList);
  }

  updateFavoriteAppsListAndState(List<String> updatedList) async {
    List<Application> updatedFavAppsList =
        await convertToListOfApps(updatedList);

    setState(() {
      favoriteApps = updatedFavAppsList;
    });

    saveFavoriteAppsToSharedPrefs(updatedList);
  }

  Future<List<Application>> convertToListOfApps(List<String> appList) async {
    List<Application> applicationsList = List<Application>();

    for (var packageName in appList) {
      final app = await DeviceApps.getApp(packageName, true);
      applicationsList.add(app);
      print(app.packageName);
    }

    return applicationsList;
  }

  @override
  void initState() {
    super.initState();
    getAllApplications();
    fetchFavoriteAppsFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<Application>> favApps = convertToListOfApps(favoriteApps);
    //to state
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SimpleGestureDetector(
            onHorizontalSwipe: (direction) {
              if (direction == SwipeDirection.left) {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: AllAppsPage(
                      allApps: _apps,
                      favoriteApps:
                          favoriteApps.map((app) => app.packageName).toList(),
                    ),
                  ),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Clock(),
                Expanded(
                  child: AppsList(
                    apps: favoriteApps,
                    favoriteApps:
                        favoriteApps.map((app) => app.packageName).toList(),
                    onUpdateFavoriteApps: updateFavoriteAppsListAndState,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
