import 'package:ascetic_launcher/bloc/all_apps/bloc.dart';
import 'package:ascetic_launcher/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'apps_list.dart';

class AllAppsPage extends StatefulWidget {
  @override
  _AllAppsPageState createState() => _AllAppsPageState();
}

class _AllAppsPageState extends State<AllAppsPage> {
  AllAppsBloc allAppsBloc;

  @override
  void initState() {
    super.initState();
    setState(() {
      allAppsBloc = BlocProvider.of<AllAppsBloc>(context);
    });
    allAppsBloc.dispatch(GetAllApps());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        allAppsBloc.dispatch(GetAllApps());
        return true;
      },
      child: Scaffold(
        body: Container(
          child: SafeArea(
            child: SimpleGestureDetector(
              onHorizontalSwipe: (direction) {
                if (direction == SwipeDirection.right) {
                  Navigator.pop(context);
                  allAppsBloc.dispatch(GetAllApps());
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
                  BlocBuilder<AllAppsBloc, AllAppsState>(
                    bloc: BlocProvider.of<AllAppsBloc>(context),
                    builder: (context, state) {
                      if (state is AllAppsLoaded) {
                        return Expanded(
                          child: AppsList(
                            apps: state.allApps,
                          ),
                        );
                      } else if (state is AppsFound) {
                        return Expanded(
                          child: AppsList(
                            apps: state.foundApps,
                          ),
                        );
                      } else if (state is FindingApps) {
                        return Column(
                          children: <Widget>[
                            Text('Searching for matching apps. Please wait'),
                            SizedBox(
                              height: 30.0,
                            ),
                            CircularProgressIndicator()
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
