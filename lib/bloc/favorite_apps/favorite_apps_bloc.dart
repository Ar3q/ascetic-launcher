import 'dart:async';
import 'package:ascetic_launcher/repositories/favorite_apps/favorite_apps_repository.dart';
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
      // yield AppAddedToFavoriteApps(addedApp: event.appToAdd);
      // await Future.delayed(Duration(seconds: 1));

      List<Application> favoriteApps =
          await favoriteAppsRepository.getFavoriteApplications();
      try {
        favoriteApps = await favoriteAppsRepository
            .addFavoriteApplicationAndGetListOfFavApps(event.appToAdd);
      } catch (e) {
        print('tralalalala');
        yield CannotAddMoreAppsToFavoriteApps();
        print('tralalalala2');
      } finally {
        yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
      }
    } else if (event is DeleteFromFavoriteApps) {
      final List<Application> favoriteApps = await favoriteAppsRepository
          .removeFavoriteApplicationAndGetListOfFavApps(event.appToDelete);

      // yield AppDeletedFromFavoriteApps(deletedApp: event.appToDelete);
      yield FavoriteAppsLoaded(favoriteApps: favoriteApps);
    }
  }
}
