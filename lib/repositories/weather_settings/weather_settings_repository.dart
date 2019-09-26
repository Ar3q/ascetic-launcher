import 'package:ascetic_launcher/repositories/weather_settings/weather_settings_shared_preferences.dart';
import 'package:flutter/foundation.dart';

class WeatherSettingsRepository {
  final WeatherSettingsSharedPreferences weatherSettingsSharedPreferences;

  WeatherSettingsRepository({@required this.weatherSettingsSharedPreferences})
      : assert(weatherSettingsSharedPreferences != null);

  Future<Map<String, dynamic>> getWeatherSettings() async {
    bool isEnabled =
        await weatherSettingsSharedPreferences.isWeatherCardEnabled();
    String city = await weatherSettingsSharedPreferences.getCityForWeather();
    Map<String, dynamic> weatherSettingsMap = Map();
    weatherSettingsMap['isEnabled'] = isEnabled;
    weatherSettingsMap['city'] = city;
    return weatherSettingsMap;
  }

  Future setWeatherSettings(bool isEnabled, String city) async {
    await weatherSettingsSharedPreferences.setWeatherCardEnabled(isEnabled);
    await weatherSettingsSharedPreferences.setCityForWeather(city);
  }
}
