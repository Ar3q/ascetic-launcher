import 'package:ascetic_launcher/bloc/all_apps/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/bloc.dart';
import 'package:ascetic_launcher/repositories/all_apps/all_apps_data_provider.dart';
import 'package:ascetic_launcher/repositories/all_apps/all_apps_repository.dart';
import 'package:ascetic_launcher/repositories/weather/weather-api-client.dart';
import 'package:ascetic_launcher/repositories/weather/weather-repository.dart';
import 'package:http/http.dart' as http;

import 'bloc/favorite_apps/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ascetic_launcher_page.dart';
import 'repositories/favorite_apps/favorite_apps_repository.dart';
import 'repositories/favorite_apps/favorite_apps_shared_preferences.dart';

void main() {
  final FavoriteAppsRepository favoriteAppsRepository = FavoriteAppsRepository(
    favoriteAppsSharedPreferences: FavoriteAppsSharedPreferences(),
  );

  final AllAppsRepository allAppsRepository = AllAppsRepository(
    allAppsDataProvider: AllAppsDataProvider(),
  );

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(MyApp(
    favoriteAppsRepository: favoriteAppsRepository,
    allAppsRepository: allAppsRepository,
    weatherRepository: weatherRepository,
  ));
}

class MyApp extends StatelessWidget {
  final FavoriteAppsRepository favoriteAppsRepository;
  final AllAppsRepository allAppsRepository;
  final WeatherRepository weatherRepository;

  const MyApp({
    Key key,
    @required this.favoriteAppsRepository,
    @required this.allAppsRepository,
    @required this.weatherRepository,
  })  : assert(favoriteAppsRepository != null),
        assert(allAppsRepository != null),
        assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteAppsBloc>(
          builder: (context) => FavoriteAppsBloc(
            favoriteAppsRepository: favoriteAppsRepository,
          ),
        ),
        BlocProvider<AllAppsBloc>(
          builder: (context) => AllAppsBloc(
            allAppsRepository: allAppsRepository,
          ),
        ),
        BlocProvider<WeatherBloc>(
          builder: (context) => WeatherBloc(
            weatherRepository: weatherRepository,
          ),
        )
      ],
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
