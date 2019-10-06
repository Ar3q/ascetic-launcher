import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  final double temperature;

  const Temperature({@required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            temperature.toStringAsFixed(1) + ' °C',
            style: TextStyle(
              fontSize: 25.0,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          // Image.asset(
          //   'assets/weather/iconfinder_weather-21.png',
          //   scale: 4.0,
          // ),
        ],
      ),
    );
  }
}
