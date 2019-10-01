import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:ascetic_launcher/repositories/weather/weather_api_client.dart';
import 'package:flutter/foundation.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient}) : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    // return await weatherApiClient.fetchWeatherForCity(city);
    return await weatherApiClient.fetchWeather();
  }

}