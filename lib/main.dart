import 'package:flutter/material.dart';

import 'AsceticLauncherPage.dart';

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
      home: SafeArea(
        child: AsceticLauncherPage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}
