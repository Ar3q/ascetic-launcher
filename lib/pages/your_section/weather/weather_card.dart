import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:ascetic_launcher/pages/your_section/weather/cloudiness.dart';
import 'package:ascetic_launcher/pages/your_section/weather/temperature.dart';
import 'package:ascetic_launcher/pages/your_section/weather/weather_icon.dart';
import 'package:flutter/material.dart';

const double weatherCardHeight = 150.0;
final double topPositionedForInfo = 40.0;
final double bottomPositionedForWeatherImage =
    weatherCardHeight - 2 * topPositionedForInfo;

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({this.weather});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: weatherCardHeight,
        ),
        Positioned.fill(
          top: topPositionedForInfo,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey[200],
            ),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      weather.location,
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Temperature(
                      temperature: weather.main.temp,
                    ),
                    Cloudiness(
                      cloudinessInPercents: weather.clouds.all,
                    ),
                    Text(weather.weatherInfo.description),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: bottomPositionedForWeatherImage,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
            ),
            child: WeatherIcon(
              condition: weather.conditionForIcon,
              iconScale: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
