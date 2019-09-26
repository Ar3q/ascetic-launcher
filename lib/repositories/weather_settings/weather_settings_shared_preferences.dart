import 'package:ascetic_launcher/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherSettingsSharedPreferences {
  Future<bool> isWeatherCardEnabled() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences
            .getBool(isWeatherCardEnabledSharedPreferencesKey) ??
        true;
  }

  Future<void> setWeatherCardEnabled(bool isEnabled) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setBool(
        isWeatherCardEnabledSharedPreferencesKey, isEnabled);
  }

  Future<String> getCityForWeather() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString(cityForWeatherSharedPreferencesKey) ??
        'none';
  }

  Future<void> setCityForWeather(String city) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString(cityForWeatherSharedPreferencesKey, city);
  }
}
