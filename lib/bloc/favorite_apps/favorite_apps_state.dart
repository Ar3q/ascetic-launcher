import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FavoriteAppsState extends Equatable {
  FavoriteAppsState([List props = const <dynamic>[]]) : super(props);
}

class InitialFavoriteApps extends FavoriteAppsState {}

class FavoriteAppsLoaded extends FavoriteAppsState {
  final List<Application> favoriteApps;

  FavoriteAppsLoaded({this.favoriteApps}) : super([favoriteApps]);
}

class AppAddedToFavoriteApps extends FavoriteAppsState {
  final List<Application> favoriteApps;

  AppAddedToFavoriteApps({this.favoriteApps}) : super([favoriteApps]);
}

class AppDeletedFromFavoriteApps extends FavoriteAppsState {
  final List<Application> favoriteApps;

  AppDeletedFromFavoriteApps({this.favoriteApps}) : super([favoriteApps]);
}
