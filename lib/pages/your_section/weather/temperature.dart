import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  final double temperature;

  const Temperature({@required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/weather/iconfinder_weather-21.png',
            scale: 4.0,
          ),
          Text(
            temperature.toStringAsFixed(1) + ' °C',
          ),
        ],
      ),
    );
  }
}
