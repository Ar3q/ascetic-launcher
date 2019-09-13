import 'package:ascetic_launcher/models/weather/clouds.dart';
import 'package:ascetic_launcher/models/weather/main.dart';
import 'package:ascetic_launcher/models/weather/sys.dart';
import 'package:ascetic_launcher/models/weather/weather_info.dart';
import 'package:ascetic_launcher/models/weather/wind.dart';
import 'package:equatable/equatable.dart';

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  mist,
  smoke,
  haze,
  dust,
  fog,
  sand,
  ash,
  squall,
  tornado,
  clear,
  clouds
}

class Weather extends Equatable {
  final WeatherCondition conditionForIcon;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  final String location;
  final WeatherInfo weatherInfo;
  final Sys sys;

  Weather({
    this.conditionForIcon,
    this.main,
    this.wind,
    this.clouds,
    this.location,
    this.weatherInfo,
    this.sys,
  }) : super([
          conditionForIcon,
          main,
          wind,
          clouds,
          location,
          weatherInfo,
          sys,
        ]);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json["clouds"]),
      location: json["name"],
      weatherInfo: WeatherInfo.fromJson(json['weather'][0]),
      conditionForIcon:
          getConditionForIcon(WeatherInfo.fromJson(json['weather'][0]).id),
      sys: Sys.fromJson(json['sys']),
    );
  }

  static WeatherCondition getConditionForIcon(int id) {
    if (id >= 200 && id <= 232) {
      return WeatherCondition.thunderstorm;
    } else if (id >= 300 && id <= 321) {
      return WeatherCondition.drizzle;
    } else if (id >= 500 && id <= 531) {
      return WeatherCondition.rain;
    } else if (id >= 600 && id <= 622) {
      return WeatherCondition.snow;
    } else if (id == 701) {
      return WeatherCondition.mist;
    } else if (id == 711) {
      return WeatherCondition.smoke;
    } else if (id == 721) {
      return WeatherCondition.haze;
    } else if (id == 731) {
      return WeatherCondition.dust;
    } else if (id == 741) {
      return WeatherCondition.fog;
    } else if (id == 751) {
      return WeatherCondition.sand;
    } else if (id == 761) {
      return WeatherCondition.dust;
    } else if (id == 762) {
      return WeatherCondition.ash;
    } else if (id == 771) {
      return WeatherCondition.squall;
    } else if (id == 781) {
      return WeatherCondition.tornado;
    } else if (id == 800) {
      return WeatherCondition.clear;
    } else if (id > 800 && id <= 804) {
      return WeatherCondition.clouds;
    } else {
      throw Exception('Condition for icon not found. Given id: $id');
    }
  }
}
