import 'package:ascetic_launcher/constants/keys.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteAppsSharedPreferences {
  static const maxNumberOfFavoriteApps = 4;

  FavoriteAppsSharedPreferences();

  Future<List<Application>> getFavoriteApps() async {
    final List<String> appsFromSharedPreferences =
        await _getFavoriteAppsFromSharedPreferences();
    final List<Application> favoriteApps =
        await _convertStringListOfFavoriteAppsToApplicationList(
            appsFromSharedPreferences);

    return favoriteApps;
  }

  Future<List<String>> _getFavoriteAppsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favAppsStringList = prefs.getStringList(FAVORITE_APPLICATIONS_SHARED_PREFERENCES_KEY) ?? [];

    return favAppsStringList;
  }

  Future<List<Application>> _convertStringListOfFavoriteAppsToApplicationList(
      List<String> listOfStringApps) async {
    List<Application> appsList = List<Application>();

    for (var stringApp in listOfStringApps) {
      final app = await DeviceApps.getApp(stringApp, true);
      appsList.add(app);
    }

    return appsList;
  }

  Future<Application> addToFavoriteApp(Application app) async {
    final List<String> favoriteAppsFromSharedPrefs =
        await _getFavoriteAppsFromSharedPreferences();

    if (favoriteAppsFromSharedPrefs.length < maxNumberOfFavoriteApps) {
      favoriteAppsFromSharedPrefs.add(app.packageName);
      _saveStringListOfFavoriteAppsToSharedPreferences(
          favoriteAppsFromSharedPrefs);
    } else {
      throw Exception('Maximum $maxNumberOfFavoriteApps favorite apps allowed!');
    }

    return app;
  }

  Future<Application> deleteFromFavoriteApps(Application app) async {
    final List<String> favoriteAppsFromSharedPrefs =
        await _getFavoriteAppsFromSharedPreferences();

    favoriteAppsFromSharedPrefs.remove(app.packageName);
    _saveStringListOfFavoriteAppsToSharedPreferences(
        favoriteAppsFromSharedPrefs);

    return app;
  }
  
  Future<void> _saveStringListOfFavoriteAppsToSharedPreferences(
      List<String> favoriteApps) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(FAVORITE_APPLICATIONS_SHARED_PREFERENCES_KEY, favoriteApps);
  }
}