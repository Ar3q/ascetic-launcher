import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

const key = 'favorite_apps';

class FavoriteAppsBloc extends Bloc<FavoriteAppsEvent, FavoriteAppsState> {
  @override
  FavoriteAppsState get initialState => InitialFavoriteApps();

  @override
  Stream<FavoriteAppsState> mapEventToState(
    FavoriteAppsEvent event,
  ) async* {
    if (event is GetFavoriteApps) {
      final List<Application> favoriteApps = await getFavoriteApps();

      yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
    } else if (event is AddToFavoriteApps) {
      final List<Application> favoriteApps =
          await addToFavoriteApp(event.appToAdd);
      // print(favoriteApps.length);
      // yield AppAddedToFavoriteApps(favoriteApps: favoriteApps);
      yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
    } else if (event is DeleteFromFavoriteApps) {
      final List<Application> favoriteApps =
          await deleteFromFavoriteApps(event.appToDelete);

      // yield AppDeletedFromFavoriteApps(favoriteApps: favoriteApps);
      yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
    }
  }

  Future<List<Application>> getFavoriteApps() async {
    final List<String> appsFromSharedPreferences =
        await getFavoriteAppsFromSharedPreferences();
    final List<Application> favoriteApps =
        await convertStringListOfFavoriteAppsToApplicationList(
            appsFromSharedPreferences);

    return favoriteApps;
  }

  Future<List<String>> getFavoriteAppsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favAppsStringList = prefs.getStringList(key) ?? [];

    return favAppsStringList;
  }

  Future<List<Application>> convertStringListOfFavoriteAppsToApplicationList(
      List<String> listOfStringApps) async {
    List<Application> appsList = List<Application>();

    for (var stringApp in listOfStringApps) {
      final app = await DeviceApps.getApp(stringApp, true);
      appsList.add(app);
    }

    return appsList;
  }

  Future<List<Application>> addToFavoriteApp(Application app) async {
    final List<String> favoriteAppsFromSharedPrefs =
        await getFavoriteAppsFromSharedPreferences();

    if (favoriteAppsFromSharedPrefs.length < 4) {
      favoriteAppsFromSharedPrefs.add(app.packageName);
      saveStringListOfFavoriteAppsToSharedPreferences(
          favoriteAppsFromSharedPrefs);
    }

    final List<Application> appsList =
        await convertStringListOfFavoriteAppsToApplicationList(
            favoriteAppsFromSharedPrefs);

    return appsList;
  }

  Future<void> saveStringListOfFavoriteAppsToSharedPreferences(
      List<String> favoriteApps) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, favoriteApps);
  }

  Future<List<Application>> deleteFromFavoriteApps(Application app) async {
    final List<String> favoriteAppsFromSharedPrefs =
        await getFavoriteAppsFromSharedPreferences();

    favoriteAppsFromSharedPrefs.remove(app.packageName);
    saveStringListOfFavoriteAppsToSharedPreferences(
        favoriteAppsFromSharedPrefs);

    final List<Application> appsList =
        await convertStringListOfFavoriteAppsToApplicationList(
            favoriteAppsFromSharedPrefs);

    return appsList;
  }
}
