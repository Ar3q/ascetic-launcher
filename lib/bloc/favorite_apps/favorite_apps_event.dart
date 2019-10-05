import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FavoriteAppsEvent extends Equatable {
  const FavoriteAppsEvent();
}

class GetFavoriteApps extends FavoriteAppsEvent {
  @override
  List<Object> get props => null;
}

class AddToFavoriteApps extends FavoriteAppsEvent {
  final Application appToAdd;

  AddToFavoriteApps(this.appToAdd);

  @override
  List<Object> get props => [appToAdd];
}

class DeleteFromFavoriteApps extends FavoriteAppsEvent {
  final Application appToDelete;

  DeleteFromFavoriteApps(this.appToDelete);

  @override
  List<Object> get props => [appToDelete];
}
