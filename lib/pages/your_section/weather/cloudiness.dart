import 'package:ascetic_launcher/constants/weather_card.dart';
import 'package:flutter/material.dart';

class Cloudiness extends StatelessWidget {
  final int cloudinessInPercents;

  const Cloudiness({@required this.cloudinessInPercents});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.cloud,
            size: sunriseAndSunsetIconSize,
            color: sunriseAndSunsetIconsColor,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            cloudinessInPercents.toString() + '%',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
