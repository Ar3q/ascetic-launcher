import 'dart:convert';

import 'package:ascetic_launcher/constants/keys.dart';
import 'package:ascetic_launcher/constants/weather_api.dart';
import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherApiClient {
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient});

  Future<String> fetchCityFromSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(cityForWeatherSharedPreferencesKey);
  }


  Future<Weather> fetchWeatherForCity(String city) async {
    final String fetchWeatherUrl = '$baseUrl/weather?q=$city&APPID=$APPID&units=metric';
    final weatherResponse = await httpClient.get(fetchWeatherUrl);

    if(weatherResponse.statusCode == 200) {
      return Weather.fromJson(json.decode(weatherResponse.body));
    } else {
      throw Exception('Failed to fetch weatcher for $city');
    }
  }

  Future<Weather> fetchWeather() async {
    String city = await fetchCityFromSharedPreferences();
    final String fetchWeatherUrl = '$baseUrl/weather?q=$city&APPID=$APPID&units=metric';
    final weatherResponse = await httpClient.get(fetchWeatherUrl);

    if(weatherResponse.statusCode == 200) {
      return Weather.fromJson(json.decode(weatherResponse.body));
    } else {
      throw Exception('Failed to fetch weatcher for $city');
    }
  }
}
