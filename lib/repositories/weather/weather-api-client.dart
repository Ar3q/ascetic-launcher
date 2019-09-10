import 'dart:convert';

import 'package:ascetic_launcher/constants/weather-api.dart';
import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient});

  Future<Weather> fetchWeather(String city) async {
    final String fetchWeatherUrl = '$baseUrl/weather?q=$city&APPID=$APPID&units=metric';
    final weatherResponse = await httpClient.get(fetchWeatherUrl);

    if(weatherResponse.statusCode == 200) {
      print(json.decode(weatherResponse.body));
      return Weather.fromJson(json.decode(weatherResponse.body));
    } else {
      throw Exception('Failed to fetch weatcher for $city');
    }
  }
}
