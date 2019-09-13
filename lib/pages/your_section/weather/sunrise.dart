import 'package:flutter/material.dart';

class Sunrise extends StatelessWidget {
  final DateTime sunrise;

  const Sunrise({@required this.sunrise});

  @override
  Widget build(BuildContext context) {
    String sunriseHour = getHourOrMinuteWithZeroIfNeeded(sunrise.hour);
    String sunriseMinute = getHourOrMinuteWithZeroIfNeeded(sunrise.minute);

    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/weather/sunrise.png',
            scale: 2.0,
          ),
          Text('$sunriseHour:$sunriseMinute'),
        ],
      ),
    );
  }

  String getHourOrMinuteWithZeroIfNeeded(int time) {
    return time < 10 ? '0' + time.toString() : time.toString();
  }
}
