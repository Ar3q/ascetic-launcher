import 'package:ascetic_launcher/constants/weather_card.dart';
import 'package:flutter/material.dart';

class SunriseOrSunset extends StatelessWidget {
  final DateTime sunriseOrSunset;
  final bool isSunrise;

  const SunriseOrSunset({@required this.sunriseOrSunset, @required this.isSunrise});

  @override
  Widget build(BuildContext context) {
    String hour = getHourOrMinuteWithZeroIfNeeded(sunriseOrSunset.hour);
    String minute = getHourOrMinuteWithZeroIfNeeded(sunriseOrSunset.minute);

    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                bottom: sunriseAndSunsetIconBottomPadding),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  top: 9.0,
                  child: Icon(
                    isSunrise ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: sunriseAndSunsetIconsColor,
                    size: sunriseAndSunsetIconSize,
                  ),
                ),
                Icon(
                  Icons.wb_sunny,
                  color: sunriseAndSunsetIconsColor,
                  size: sunriseAndSunsetIconSize,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text('$hour:$minute'),
        ],
      ),
    );
  }

  String getHourOrMinuteWithZeroIfNeeded(int time) {
    return time < 10 ? '0' + time.toString() : time.toString();
  }
}
