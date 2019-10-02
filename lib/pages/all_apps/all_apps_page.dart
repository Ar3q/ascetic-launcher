import 'package:ascetic_launcher/bloc/all_apps/bloc.dart';
import 'package:ascetic_launcher/bloc/favorite_apps/bloc.dart';
import 'package:ascetic_launcher/pages/all_apps/widgets/search_field.dart';
import 'package:ascetic_launcher/pages/common_widgets/apps_list.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class AllAppsPage extends StatefulWidget {
  final List<Application> allApps;

  const AllAppsPage({@required this.allApps}) : assert(allApps != null);

  @override
  _AllAppsPageState createState() => _AllAppsPageState();
}

class _AllAppsPageState extends State<AllAppsPage> {
  AllAppsBloc allAppsBloc;
  int buildCounter = 0;
  Widget component = Container();

  @override
  void initState() {
    super.initState();
    setState(() {
      allAppsBloc = BlocProvider.of<AllAppsBloc>(context);
    });
    // allAppsBloc.dispatch(GetAllApps());
  }

  @override
  Widget build(BuildContext context) {
    print('builded $buildCounter');
    buildCounter++;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BlocListener<FavoriteAppsBloc, FavoriteAppsState>(
        listener: (context, state) {
          if (state is CannotAddMoreAppsToFavoriteApps) {
            Fluttertoast.showToast(
              msg: 'Maximum 5 favorite apps is allowed',
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        child: Scaffold(
          body: Container(
            child: SafeArea(
              child: SimpleGestureDetector(
                onHorizontalSwipe: (direction) {
                  if (direction == SwipeDirection.left) {
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
                        apps: widget.allApps,
                      ),
                    )
                    // BlocBuilder<AllAppsBloc, AllAppsState>(
                    //   builder: (context, state) {
                    //     print('bloc builder');
                    //     if (state is AllAppsLoaded) {
                    // return Expanded(
                    //   child: AppsList(
                    //     apps: state.allApps,
                    //   ),
                    // );
                    //     } else if (state is AppsFound) {
                    //       return Expanded(
                    //         child: AppsList(
                    //           apps: state.foundApps,
                    //         ),
                    //       );
                    //     } else if (state is FindingApps) {
                    //       return Column(
                    //         children: <Widget>[
                    //           Text('Searching for matching apps. Please wait'),
                    //           SizedBox(
                    //             height: 30.0,
                    //           ),
                    //           CircularProgressIndicator()
                    //         ],
                    //       );
                    //     } else {
                    //       return CircularProgressIndicator();
                    //     }
                    //   },
                    // )
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
