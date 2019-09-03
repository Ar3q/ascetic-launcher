import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FavoriteAppsEvent extends Equatable {
  FavoriteAppsEvent([List props = const <dynamic>[]]) : super(props);
}

class GetFavoriteApps extends FavoriteAppsEvent {}

class AddToFavoriteApps extends FavoriteAppsEvent {
  final Application appToAdd;

  AddToFavoriteApps(this.appToAdd) : super([appToAdd]);
}

class DeleteFromFavoriteApps extends FavoriteAppsEvent {
  final Application appToDelete;

  DeleteFromFavoriteApps(this.appToDelete) : super([appToDelete]);
}
