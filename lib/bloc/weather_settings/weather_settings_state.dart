import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherSettingsState extends Equatable {
  WeatherSettingsState([List props = const <dynamic>[]]) : super(props);
}

class LoadingWeatherSettingsState extends WeatherSettingsState {}

class LoadedWeatherSettingsState extends WeatherSettingsState {
  final bool isWeatherCardEnabled;
  final String city;

  LoadedWeatherSettingsState(
      {@required this.isWeatherCardEnabled, @required this.city})
      : super([isWeatherCardEnabled, city]);
}

class UpdatedWeatherSettingsState extends WeatherSettingsState {
  final bool isWeatherCardEnabled;
  final String city;

  UpdatedWeatherSettingsState(
      {@required this.isWeatherCardEnabled, @required this.city})
      : super([isWeatherCardEnabled, city]);
}
