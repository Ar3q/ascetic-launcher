import 'package:flutter/material.dart';

class Cloudiness extends StatelessWidget {
  final int cloudinessInPercents;

  const Cloudiness({@required this.cloudinessInPercents});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/weather/iconfinder_weather-02.png',
            scale: 4.0,
          ),
          Text(
            cloudinessInPercents.toString() + '%',
          )
        ],
      ),
    );
  }
}
