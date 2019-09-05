import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';

import 'favorite_apps_shared_preferences.dart';

class FavoriteAppsRepository {
  final FavoriteAppsSharedPreferences favoriteAppsSharedPreferences;

  FavoriteAppsRepository({@required this.favoriteAppsSharedPreferences})
      : assert(favoriteAppsSharedPreferences != null);

  Future<List<Application>> getFavoriteApplications() async {
    final List<Application> favoriteApplications = await favoriteAppsSharedPreferences.getFavoriteApps();

    return favoriteApplications;
  }

  Future<List<Application>> addFavoriteApplicationAndGetListOfFavApps(Application app) async {
    try {
      await favoriteAppsSharedPreferences.addToFavoriteApp(app);
    } catch (e) {
      print(e);
    }
    
    return await getFavoriteApplications();
  }

  Future<List<Application>> removeFavoriteApplicationAndGetListOfFavApps(Application app) async {
    try {
      await favoriteAppsSharedPreferences.deleteFromFavoriteApps(app);
    } catch (e) {
      print(e);
    }
    
    return await getFavoriteApplications();
  }

}
