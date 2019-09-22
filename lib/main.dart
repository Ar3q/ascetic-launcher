import 'package:app_usage/app_usage.dart';
import 'package:ascetic_launcher/bloc/all_apps/bloc.dart';
import 'package:ascetic_launcher/bloc/app_usage/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/bloc.dart';
import 'package:ascetic_launcher/pages/main/ascetic_launcher_page.dart';
import 'package:ascetic_launcher/repositories/all_apps/all_apps_data_provider.dart';
import 'package:ascetic_launcher/repositories/all_apps/all_apps_repository.dart';
import 'package:ascetic_launcher/repositories/app_usage/app_usage_data_provider.dart';
import 'package:ascetic_launcher/repositories/app_usage/app_usage_repository.dart';
import 'package:ascetic_launcher/repositories/weather/weather_api_client.dart';
import 'package:ascetic_launcher/repositories/weather/weather_repository.dart';
import 'package:http/http.dart' as http;

import 'bloc/favorite_apps/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final AppUsageRepository appUsageRepository = AppUsageRepository(
    appUsageDataProvider: AppUsageDataProvider(
      appUsage: AppUsage(),
    ),
  );

  runApp(MyApp(
    favoriteAppsRepository: favoriteAppsRepository,
    allAppsRepository: allAppsRepository,
    weatherRepository: weatherRepository,
    appUsageRepository: appUsageRepository,
  ));
}

class MyApp extends StatelessWidget {
  final FavoriteAppsRepository favoriteAppsRepository;
  final AllAppsRepository allAppsRepository;
  final WeatherRepository weatherRepository;
  final AppUsageRepository appUsageRepository;

  const MyApp({
    Key key,
    @required this.favoriteAppsRepository,
    @required this.allAppsRepository,
    @required this.weatherRepository,
    @required this.appUsageRepository,
  })  : assert(favoriteAppsRepository != null),
        assert(allAppsRepository != null),
        assert(weatherRepository != null),
        assert(appUsageRepository != null),
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
        ),
        BlocProvider<AppUsageBloc>(
          builder: (context) => AppUsageBloc(
            appUsageRepository: appUsageRepository,
          ),
        ),
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
