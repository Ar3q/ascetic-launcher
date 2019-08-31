import 'package:ascetic_launcher/search_field.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'apps_list.dart';

class AllAppsPage extends StatelessWidget {
  final List<Application> allApps;
  final List<String> favoriteApps;

  const AllAppsPage({this.allApps, this.favoriteApps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: SimpleGestureDetector(
            onHorizontalSwipe: (direction) {
              if (direction == SwipeDirection.right) {
                Navigator.pop(context);
              }
            },
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    'All your applications',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SearchField(),
                SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: AppsList(
                    apps: allApps,
                    favoriteApps: favoriteApps,
                    // onUpdateFavoriteApps: updateFavoriteAppsListAndState,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
