import 'package:ascetic_launcher/models/weather/clouds.dart';
import 'package:ascetic_launcher/models/weather/main.dart';
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
  snad,
  ash,
  squall,
  tornado,
  clear,
  clouds
}

class Weather extends Equatable {
  // final WeatherCondition condition;
  // final String description;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  final String location;

  Weather(
      {
      // this.condition,
      this.main,
      // this.description,
      this.wind,
      this.clouds,
      this.location})
      : super([
          // condition,
          main,
          // description,
          wind,
          clouds,
          location
        ]);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        // description: json['weather']['description'],
        main: Main.fromJson(json['main']),
        wind: Wind.fromJson(json['wind']),
        clouds: Clouds.fromJson(json["clouds"]),
        location: json["name"]);
  }
}
