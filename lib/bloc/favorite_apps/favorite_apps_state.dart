import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FavoriteAppsState extends Equatable {
  const FavoriteAppsState();
}

class InitialFavoriteApps extends FavoriteAppsState {
  @override
  List<Object> get props => null;
}

class FavoriteAppsLoaded extends FavoriteAppsState {
  final List<Application> favoriteApps;

  FavoriteAppsLoaded({this.favoriteApps});

  @override
  List<Object> get props => [favoriteApps];
}

class AppAddedToFavoriteApps extends FavoriteAppsState {
  final Application addedApp;

  AppAddedToFavoriteApps({this.addedApp});

  @override
  List<Object> get props => [addedApp];
}

class AppDeletedFromFavoriteApps extends FavoriteAppsState {
  final Application deletedApp;

  AppDeletedFromFavoriteApps({this.deletedApp});

  @override
  List<Object> get props => [deletedApp];
}

class CannotAddMoreAppsToFavoriteApps extends FavoriteAppsState {
  @override
  List<Object> get props => null;
}