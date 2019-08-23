import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import 'app_list_item.dart';

class AppsList extends StatelessWidget {
  final apps;
  final favoriteApps;
  final onUpdateFavoriteApps;

  const AppsList({this.onUpdateFavoriteApps, this.favoriteApps, this.apps});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: apps.length,
        itemBuilder: (context, i) => listItemBuilder(context, i),
        separatorBuilder: (context, i) => Divider(),
      ),
    );
  }

  Widget listItemBuilder(BuildContext context, int index) {
    final app = apps[index];
    final isFavoriteApp = favoriteApps.contains(app.packageName);
    return AppListItem(
      app: app,
      isFavorite: isFavoriteApp,
      onFavoriteClicked: () async => await onFavoriteClicked(app, isFavoriteApp),
    );
  }

  onFavoriteClicked(Application app, bool isFavoriteApp) async {
    print(favoriteApps);

    if (isFavoriteApp) {
      await removeFromFavoriteApps(app);
    } else {
      await addToFavoriteApps(app);
    }
  }

  removeFromFavoriteApps(Application app) async {
    List<String> updatedFavAppsList = List<String>();
    updatedFavAppsList = favoriteApps;
    updatedFavAppsList.remove(app.packageName);

    await onUpdateFavoriteApps(updatedFavAppsList);
  }

  addToFavoriteApps(Application app) async {
    if (favoriteApps.length < 4) {
      List<String> updatedFavAppsList = List<String>();
      updatedFavAppsList = favoriteApps;
      updatedFavAppsList.add(app.packageName);

      await onUpdateFavoriteApps(updatedFavAppsList);
    } else {
      print('max 4 apps');
    }
  }
}
