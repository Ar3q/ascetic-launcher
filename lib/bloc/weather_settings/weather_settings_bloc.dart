import 'dart:async';
import 'package:ascetic_launcher/repositories/weather_settings/weather_settings_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class WeatherSettingsBloc
    extends Bloc<WeatherSettingsEvent, WeatherSettingsState> {
  final WeatherSettingsRepository weatherSettingsRepository;

  WeatherSettingsBloc({@required this.weatherSettingsRepository})
      : assert(weatherSettingsRepository != null);

  @override
  WeatherSettingsState get initialState => LoadingWeatherSettingsState();

  @override
  Stream<WeatherSettingsState> mapEventToState(
    WeatherSettingsEvent event,
  ) async* {
    if (event is GetWeatherSettings) {
      yield LoadingWeatherSettingsState();
      Map<String, dynamic> weatherSettings =
          await weatherSettingsRepository.getWeatherSettings();
      yield LoadedWeatherSettingsState(
        city: weatherSettings['city'],
        isWeatherCardEnabled: weatherSettings['isEnabled'],
      );
    } else if (event is UpdateWeatherSettings) {
      yield LoadingWeatherSettingsState();
      await weatherSettingsRepository.setWeatherSettings(
          event.isWeatherCardEnabled, event.city);
      yield UpdatedWeatherSettingsState(
        city: event.city,
        isWeatherCardEnabled: event.isWeatherCardEnabled,
      );
    }
  }
}
