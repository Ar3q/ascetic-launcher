import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double iconScale;

  const WeatherIcon({@required this.condition, this.iconScale}) : assert(condition != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getWeatherIcon(condition, iconScale),
    );
  }

  Image getWeatherIcon(WeatherCondition condition, double scale) {
    const startOfPath = 'assets/weather';
    String pathToAsset;

    switch (condition) {
      case WeatherCondition.ash:
        pathToAsset = '$startOfPath/iconfinder_weather-28_1527678.png';
        break;
      case WeatherCondition.clear:
        pathToAsset = '$startOfPath/iconfinder_weather-01.png';
        break;
      case WeatherCondition.clouds:
        pathToAsset = '$startOfPath/iconfinder_weather-02.png';
        break;
      case WeatherCondition.drizzle:
        pathToAsset = '$startOfPath/iconfinder_weather-03.png';
        break;
      case WeatherCondition.dust:
        pathToAsset = '$startOfPath/iconfinder_weather-28.png';
        break;
      case WeatherCondition.fog:
        pathToAsset = '$startOfPath/iconfinder_weather-06.png';
        break;
      case WeatherCondition.haze:
        pathToAsset = '$startOfPath/iconfinder_weather-06.png';
        break;
      case WeatherCondition.mist:
        pathToAsset = '$startOfPath/iconfinder_weather-06.png';
        break;
      case WeatherCondition.rain:
        pathToAsset = '$startOfPath/iconfinder_weather-03.png';
        break;
      case WeatherCondition.sand:
        pathToAsset = '$startOfPath/iconfinder_weather-28.png';
        break;
      case WeatherCondition.smoke:
        pathToAsset = '$startOfPath/iconfinder_weather-29.png';
        break;
      case WeatherCondition.snow:
        pathToAsset = '$startOfPath/iconfinder_weather-05.png';
        break;
      case WeatherCondition.squall:
        pathToAsset = '$startOfPath/iconfinder_weather-08.png';
        break;
      case WeatherCondition.thunderstorm:
        pathToAsset = '$startOfPath/iconfinder_weather-08.png';
        break;
      case WeatherCondition.tornado:
        pathToAsset = '$startOfPath/iconfinder_weather-29.png';
        break;
      default:
    }

    return Image.asset(
      pathToAsset,
      scale: scale?? 1.5,
      color: Colors.grey[800],
    );
  }
}
