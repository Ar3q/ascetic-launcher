import 'package:ascetic_launcher/bloc/favorite_apps_bloc.dart';
import 'package:ascetic_launcher/repositories/favorite_apps_repository.dart';
import 'package:ascetic_launcher/repositories/favorite_apps_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ascetic_launcher_page.dart';

void main() {
  final FavoriteAppsRepository favoriteAppsRepository = FavoriteAppsRepository(
    favoriteAppsSharedPreferences: FavoriteAppsSharedPreferences(),
  );

  runApp(MyApp(
    favoriteAppsRepository: favoriteAppsRepository,
  ));
}

class MyApp extends StatelessWidget {
  final FavoriteAppsRepository favoriteAppsRepository;

  const MyApp({Key key, @required this.favoriteAppsRepository})
      : assert(favoriteAppsRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteAppsBloc>(
      builder: (context) =>
          FavoriteAppsBloc(favoriteAppsRepository: favoriteAppsRepository),
      child: MaterialApp(
        title: 'Ascetic Launcher',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: AsceticLauncherPage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}
