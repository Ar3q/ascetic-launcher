import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            weather.location,
          ),
          Text(
            weather.main.temp.toString(),
          ),
        ],
      ),
    );
  }
}