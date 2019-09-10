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
  final String description;
  final double temperatre;
  final double pressure;
  final int humidity;
  final double windSpeed;
  final int cloudiness;
  final String location;

  Weather(
      {
      // this.condition,
      this.description,
      this.temperatre,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.cloudiness,
      this.location})
      : super([
          // condition,
          description,
          temperatre,
          pressure,
          humidity,
          windSpeed,
          cloudiness,
          location
        ]);

  static Weather fromJson(dynamic json) {
    return Weather(
      description: json['weather']['description'],
      temperatre: json['main']['temp'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      cloudiness: json["clouds"]["all"],
      location: json["name"]
    );
  }
}
