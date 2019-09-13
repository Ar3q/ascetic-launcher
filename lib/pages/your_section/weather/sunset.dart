import 'package:flutter/material.dart';

class Sunset extends StatelessWidget {
  final DateTime sunset;

  const Sunset({@required this.sunset});

  @override
  Widget build(BuildContext context) {
    String sunsetHour = getHourOrMinuteWithZeroIfNeeded(sunset.hour);
    String sunsetMinute = getHourOrMinuteWithZeroIfNeeded(sunset.minute);

    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/weather/sunset.png',
            scale: 2.0,
          ),
          Text('$sunsetHour:$sunsetMinute'),
        ],
      ),
    );
  }

  String getHourOrMinuteWithZeroIfNeeded(int time) {
    return time < 10 ? '0' + time.toString() : time.toString();
  }
}
