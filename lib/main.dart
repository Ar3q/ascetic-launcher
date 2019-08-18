import 'package:flutter/material.dart';

import 'ascetic_launcher_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ascetic Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AsceticLauncherPage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}
