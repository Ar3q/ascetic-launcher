import 'dart:async';
import 'package:ascetic_launcher/repositories/favorite_apps_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/widgets.dart';
import './bloc.dart';

const key = 'favorite_apps';

class FavoriteAppsBloc extends Bloc<FavoriteAppsEvent, FavoriteAppsState> {
  final FavoriteAppsRepository favoriteAppsRepository;

  FavoriteAppsBloc({@required this.favoriteAppsRepository})
      : assert(favoriteAppsRepository != null);

  @override
  FavoriteAppsState get initialState => InitialFavoriteApps();

  @override
  Stream<FavoriteAppsState> mapEventToState(
    FavoriteAppsEvent event,
  ) async* {
    if (event is GetFavoriteApps) {
      final List<Application> favoriteApps =
          await favoriteAppsRepository.getFavoriteApplications();

      yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
    } else if (event is AddToFavoriteApps) {
      final List<Application> favoriteApps = await favoriteAppsRepository
          .addFavoriteApplicationAndGetListOfFavApps(event.appToAdd);
      // print(favoriteApps.length);
      // yield AppAddedToFavoriteApps(favoriteApps: favoriteApps);
      yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
    } else if (event is DeleteFromFavoriteApps) {
      final List<Application> favoriteApps = await favoriteAppsRepository
          .removeFavoriteApplicationAndGetListOfFavApps(event.appToDelete);

      // yield AppDeletedFromFavoriteApps(favoriteApps: favoriteApps);
      yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
    }
  }
}
