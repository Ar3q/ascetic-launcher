import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';

import 'favorite_apps_shared_preferences.dart';

class FavoriteAppsRepository {
  final FavoriteAppsSharedPreferences favoriteAppsSharedPreferences;

  FavoriteAppsRepository({@required this.favoriteAppsSharedPreferences})
      : assert(favoriteAppsSharedPreferences != null);

  Future<List<ApplicationWithIcon>> getFavoriteApplications() async {
    final List<ApplicationWithIcon> favoriteApplications = await favoriteAppsSharedPreferences.getFavoriteApps();

    return favoriteApplications;
  }

  Future<List<ApplicationWithIcon>> addFavoriteApplicationAndGetListOfFavApps(Application app) async {
    try {
      await favoriteAppsSharedPreferences.addToFavoriteApp(app);
    } catch (e) {
      throw e;
    }
    
    return await getFavoriteApplications();
  }

  Future<List<ApplicationWithIcon>> removeFavoriteApplicationAndGetListOfFavApps(Application app) async {
    try {
      await favoriteAppsSharedPreferences.deleteFromFavoriteApps(app);
    } catch (e) {
      print(e);
    }
    
    return await getFavoriteApplications();
  }

}
