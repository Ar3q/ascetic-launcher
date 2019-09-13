import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:ascetic_launcher/pages/your_section/weather/cloudiness.dart';
import 'package:ascetic_launcher/pages/your_section/weather/sunrise.dart';
import 'package:ascetic_launcher/pages/your_section/weather/sunset.dart';
import 'package:ascetic_launcher/pages/your_section/weather/temperature.dart';
import 'package:ascetic_launcher/pages/your_section/weather/weather_icon.dart';
import 'package:flutter/material.dart';

const double weatherCardHeight = 100.0;
const double topPositionedForInfo = 30.0;
const double bottomPositionedForWeatherImage = 35.0;

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({this.weather});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: weatherCardHeight,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.grey[200],
          ),
        ),
        Positioned.fill(
          top: topPositionedForInfo,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey[300],
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          weather.location,
                          style: TextStyle(fontSize: 25.0),
                        ),
                        Column(
                          children: <Widget>[
                            Text(weather.weatherInfo.description),
                            Row(
                              children: <Widget>[
                                Temperature(
                                  temperature: weather.main.temp,
                                ),
                                Cloudiness(
                                  cloudinessInPercents: weather.clouds.all,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: bottomPositionedForWeatherImage,
          left: 270.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: WeatherIcon(
              condition: weather.conditionForIcon,
              iconScale: 1.0,
            ),
          ),
        ),
        Positioned.fill(
          bottom: 70.0,
          left: 30.0,
          child: Row(
            children: <Widget>[
              Sunrise(
                sunrise: weather.sys.sunrise,
              ),
              SizedBox(
                width: 20.0,
              ),
              Sunset(
                sunset: weather.sys.sunset,
              )
            ],
          ),
        ),
      ],
    );
  }
}
