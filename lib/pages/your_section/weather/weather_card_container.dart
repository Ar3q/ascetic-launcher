import 'package:ascetic_launcher/constants/weather_card.dart';
import 'package:flutter/material.dart';

class WeatherCardContainer extends StatelessWidget {
  final Widget child;

  const WeatherCardContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: weatherCardHeight,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
      child: child,
    );
  }
}
