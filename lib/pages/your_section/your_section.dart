import 'package:ascetic_launcher/bloc/app_usage/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/weather_state.dart';
import 'package:ascetic_launcher/pages/your_section/app_usage/app_usage_card.dart';
import 'package:ascetic_launcher/pages/your_section/weather/weather_card.dart';
import 'package:ascetic_launcher/pages/your_section/weather/weather_card_container.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class YourSection extends StatefulWidget {
  const YourSection({Key key}) : super(key: key);

  @override
  _YourSectionState createState() => _YourSectionState();
}

class _YourSectionState extends State<YourSection> {
  WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    setState(() {
      weatherBloc = BlocProvider.of<WeatherBloc>(context);
    });
    weatherBloc.dispatch(GetWeather(city: 'Tyczyn'));
    initGettingAppUsageStats();
  }

  void initGettingAppUsageStats() {
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);
    BlocProvider.of<AppUsageBloc>(context).dispatch(GetAppUsage(
      startTime: startDate,
      endTime: endDate,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    'Hello',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is InitialWeatherState) {
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WeatherLoading) {
                      return CircularProgressIndicator();
                    } else if (state is WeatherLoaded) {
                      return WeatherCard(
                        weather: state.weather,
                      );
                    } else if (state is WeatherError) {
                      return WeatherCardContainer(
                        child: Text('error'),
                      );
                    } else if (state is NotConnectedToNetwork) {
                      return WeatherCardContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Connect to network'),
                            GestureDetector(
                              onTap: () async {
                                ConnectivityResult connectivityResult =
                                    await Connectivity().checkConnectivity();
                                if (connectivityResult !=
                                    ConnectivityResult.none) {
                                  weatherBloc.dispatch(
                                    GetWeather(city: 'Tyczyn'),
                                  );
                                }
                              },
                              child: Icon(
                                Icons.refresh,
                                size: 30.0,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 282.0,
                  child: AppUsageCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
