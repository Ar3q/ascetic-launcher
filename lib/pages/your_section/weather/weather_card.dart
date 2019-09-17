import 'package:ascetic_launcher/constants/weather_card.dart';
import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:ascetic_launcher/pages/your_section/weather/cloudiness.dart';
import 'package:ascetic_launcher/pages/your_section/weather/sunrise_or_sunset.dart';
import 'package:ascetic_launcher/pages/your_section/weather/temperature.dart';
import 'package:ascetic_launcher/pages/your_section/weather/weather_card_container.dart';
import 'package:ascetic_launcher/pages/your_section/weather/weather_icon.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({this.weather});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WeatherCardContainer(),
        Positioned.fill(
          top: topPositionedForInfo,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey[300],
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '${weather.location},',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        SizedBox(width: 5.0,),
                        Temperature(
                          temperature: weather.main.temp,
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
              SunriseOrSunset(
                sunriseOrSunset: weather.sys.sunrise,
                isSunrise: true,
              ),
              SizedBox(
                width: 20.0,
              ),
              SunriseOrSunset(
                sunriseOrSunset: weather.sys.sunset,
                isSunrise: false,
              ),
              SizedBox(
                width: 20.0,
              ),
              Cloudiness(
                cloudinessInPercents: weather.clouds.all,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
