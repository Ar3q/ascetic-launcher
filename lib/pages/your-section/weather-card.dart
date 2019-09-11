import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[200],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.0),
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
