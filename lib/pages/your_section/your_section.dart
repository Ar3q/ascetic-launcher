import 'package:ascetic_launcher/bloc/app_usage/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/weather_state.dart';
import 'package:ascetic_launcher/bloc/weather_settings/bloc.dart';
import 'package:ascetic_launcher/pages/settings/settings_page.dart';
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
  bool shouldBeWeatherCardShown = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      weatherBloc = BlocProvider.of<WeatherBloc>(context);
    });
    weatherBloc.dispatch(GetWeather(city: 'Tyczyn'));
    initGettingAppUsageStats();
    BlocProvider.of<WeatherSettingsBloc>(context)
        .dispatch(GetWeatherSettings());
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
    return BlocListener<WeatherSettingsBloc, WeatherSettingsState>(
      listener: (context, state) {
        if (state is LoadedWeatherSettingsState) {
          setState(() {
            shouldBeWeatherCardShown = state.isWeatherCardEnabled;
          });
        } else if (state is UpdatedWeatherSettingsState) {
          setState(() {
            shouldBeWeatherCardShown = state.isWeatherCardEnabled;
          });
        }
      },
      child: Scaffold(
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
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Hello',
                            style: TextStyle(fontSize: 50.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 10.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettingsPage(),
                                    ));
                              },
                              child: Icon(Icons.settings),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Visibility(
                    visible: shouldBeWeatherCardShown,
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is InitialWeatherState ||
                            state is WeatherLoading) {
                          return WeatherCardContainer(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
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
                                        await Connectivity()
                                            .checkConnectivity();
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
      ),
    );
  }
}
