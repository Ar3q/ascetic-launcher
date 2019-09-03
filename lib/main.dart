import 'package:ascetic_launcher/bloc/favorite_apps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ascetic_launcher_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteAppsBloc>(
      builder: (context) => FavoriteAppsBloc(),
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
