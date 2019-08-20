import 'package:ascetic_launcher/clock.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_list_item.dart';

const key = 'favofite_apps';

class AsceticLauncherPage extends StatefulWidget {
  AsceticLauncherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AsceticLauncherPageState createState() => _AsceticLauncherPageState();
}

class _AsceticLauncherPageState extends State<AsceticLauncherPage> {
  List<Application> _apps = List<Application>();
  List<String> favoriteApps = List<String>();

  getApplications() async {
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

    setState(() {
      favoriteApps = favAppsStringList;
    });
  }

  saveFavoriteAppsToSharedPrefs(List<String> newFavoriteAppsList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, newFavoriteAppsList);
  }

  updateFavoriteAppsListAndState(List<String> updatedList) {
    setState(() {
      favoriteApps = updatedList;
    });

    saveFavoriteAppsToSharedPrefs(updatedList);
  }

  @override
  void initState() {
    super.initState();
    getApplications();
    fetchFavoriteAppsFromSharedPrefs();
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
    final app = _apps[index];
    final isFavoriteApp = favoriteApps.contains(app.packageName);
    return AppListItem(
      app: app,
      isFavorite: isFavoriteApp,
      onFavoriteClicked: () => onFavoriteClicked(app, isFavoriteApp),
    );
  }

  onFavoriteClicked(Application app, bool isFavoriteApp) {
    print(favoriteApps);

    if (isFavoriteApp) {
      removeFromFavoriteApps(app);
    } else {
      addToFavoriteApps(app);
    }
  }

  removeFromFavoriteApps(Application app) {
    List<String> updatedFavAppsList = List<String>();
    updatedFavAppsList = favoriteApps;
    updatedFavAppsList.remove(app.packageName);

    updateFavoriteAppsListAndState(updatedFavAppsList);
  }

  addToFavoriteApps(Application app) {
    if (favoriteApps.length < 6) {
      List<String> updatedFavAppsList = List<String>();
      updatedFavAppsList = favoriteApps;
      updatedFavAppsList.add(app.packageName);

      updateFavoriteAppsListAndState(updatedFavAppsList);
    } else {
      print('max 5 apps');
    }
  }
}
