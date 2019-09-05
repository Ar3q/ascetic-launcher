import 'package:ascetic_launcher/all_apps_page.dart';
import 'bloc/favorite_apps/bloc.dart';
import 'package:ascetic_launcher/clock.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'apps_list.dart';

const key = 'favorite_apps';

class AsceticLauncherPage extends StatefulWidget {
  AsceticLauncherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AsceticLauncherPageState createState() => _AsceticLauncherPageState();
}

class _AsceticLauncherPageState extends State<AsceticLauncherPage> {
  List<Application> _apps = List<Application>();
  FavoriteAppsBloc favoriteAppsBloc;

  bool isShowingAllApps = false;

  getAllApplications() async {
    List<Application> appList = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);

    appList.sort((a, b) => a.appName.compareTo(b.appName));

    setState(() {
      _apps = appList;
    });
  }

  Future<List<Application>> convertToListOfApps(List<String> appList) async {
    List<Application> applicationsList = List<Application>();

    for (var packageName in appList) {
      final app = await DeviceApps.getApp(packageName, true);
      if (app != null) {
        applicationsList.add(app);
      }
    }

    return applicationsList;
  }

  @override
  void initState() {
    super.initState();
    getAllApplications();
    setState(() {
      favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);
    });
    favoriteAppsBloc.dispatch(GetFavoriteApps());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SimpleGestureDetector(
            onHorizontalSwipe: (direction) {
              if (direction == SwipeDirection.left) {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: AllAppsPage(
                      allApps: _apps,
                    ),
                  ),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Clock(),
                BlocBuilder<FavoriteAppsBloc, FavoriteAppsState>(
                  bloc: favoriteAppsBloc,
                  builder: (context, state) {
                    if (state is FavoriteAppsLoaded) {
                      return Expanded(
                        child: AppsList(
                          apps: state.favoriteApps,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
