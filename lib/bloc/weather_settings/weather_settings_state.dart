import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherSettingsState extends Equatable {
  const WeatherSettingsState();
}

class LoadingWeatherSettingsState extends WeatherSettingsState {
  @override
  List<Object> get props => null;
}

class LoadedWeatherSettingsState extends WeatherSettingsState {
  final bool isWeatherCardEnabled;
  final String city;

  LoadedWeatherSettingsState(
      {@required this.isWeatherCardEnabled, @required this.city});

  @override
  List<Object> get props => [isWeatherCardEnabled, city];
}

class UpdatedWeatherSettingsState extends WeatherSettingsState {
  final bool isWeatherCardEnabled;
  final String city;

  UpdatedWeatherSettingsState(
      {@required this.isWeatherCardEnabled, @required this.city});

  @override
  List<Object> get props => [isWeatherCardEnabled, city];
}
