import 'package:ascetic_launcher/bloc/weather/bloc.dart';
import 'package:ascetic_launcher/bloc/weather/weather_state.dart';
import 'package:ascetic_launcher/pages/your-section/weather-card.dart';
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
                Text(
                  'Hello',
                  style: TextStyle(fontSize: 30.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Card(),
                Divider(),
                Text('Hello'),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is InitialWeatherState) {
                      return CircularProgressIndicator();
                    } else if (state is WeatherLoading) {
                      return CircularProgressIndicator();
                    } else if (state is WeatherLoaded) {
                      return WeatherCard(
                        weather: state.weather,
                      );
                    } else if (state is WeatherError) {
                      return Text('error');
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
