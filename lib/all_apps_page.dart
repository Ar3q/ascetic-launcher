import 'package:ascetic_launcher/bloc/favorite_apps_bloc.dart';
import 'package:ascetic_launcher/search_field.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'apps_list.dart';
import 'bloc/bloc.dart';

class AllAppsPage extends StatefulWidget {
  final List<Application> allApps;

  const AllAppsPage({this.allApps});

  @override
  _AllAppsPageState createState() => _AllAppsPageState();
}

class _AllAppsPageState extends State<AllAppsPage> {
  FavoriteAppsBloc favoriteAppsBloc;

  @override
  void initState() {
    super.initState();
    setState(() {
      favoriteAppsBloc = BlocProvider.of<FavoriteAppsBloc>(context);
    });
    favoriteAppsBloc.dispatch(GetFavoriteApps());
  }

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
                BlocBuilder<FavoriteAppsBloc, FavoriteAppsState>(
                  bloc: favoriteAppsBloc,
                  builder: (context, state) {
                    if (state is FavoriteAppsLoaded) {
                      return Expanded(
                        child: AppsList(
                          apps: widget.allApps,
                          // favoriteApps: state.favoriteApps,
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
