import 'package:ascetic_launcher/bloc/all_apps/bloc.dart';
import 'package:ascetic_launcher/bloc/favorite_apps/bloc.dart';
import 'package:ascetic_launcher/pages/all_apps/all_apps_page.dart';
import 'package:ascetic_launcher/pages/common_widgets/apps_list.dart';
import 'package:ascetic_launcher/pages/main/widgets/bottom_dock.dart';
import 'package:ascetic_launcher/pages/main/widgets/clock.dart';
import 'package:ascetic_launcher/pages/your_section/your_section.dart';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class AsceticLauncherPage extends StatefulWidget {
  @override
  _AsceticLauncherPageState createState() => _AsceticLauncherPageState();
}

class _AsceticLauncherPageState extends State<AsceticLauncherPage> {
  FavoriteAppsBloc favoriteAppsBloc;
  AllAppsBloc allAppsBloc;

  List<Application> allApps = <Application>[];
  bool isShowingAllApps = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);
      allAppsBloc = BlocProvider.of<AllAppsBloc>(context);
    });
    favoriteAppsBloc.dispatch(GetFavoriteApps());
    allAppsBloc.dispatch(GetAllApps());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: BlocListener<AllAppsBloc, AllAppsState>(
        listener: (context, state) {
          if (state is AllAppsLoaded) {
            setState(() {
              allApps = state.allApps;
            });
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Center(
              child: SimpleGestureDetector(
                onHorizontalSwipe: (direction) {
                  if (direction == SwipeDirection.right) {
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: YourSection(),
                        ));
                  }
                },
                onVerticalSwipe: (direction) {
                  if (direction == SwipeDirection.up) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllAppsPage(
                            allApps: allApps,
                          ),
                        ));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Clock(),
                    BlocBuilder<FavoriteAppsBloc, FavoriteAppsState>(
                      bloc: favoriteAppsBloc,
                      builder: (context, state) {
                        print('bloc builder home page');
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
                    Icon(
                      Icons.keyboard_arrow_up,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    BottomDock(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
