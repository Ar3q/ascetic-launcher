import 'package:ascetic_launcher/bloc/weather/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/weather_state.dart';
import 'package:ascetic_launcher/constants/weather_card.dart';
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
