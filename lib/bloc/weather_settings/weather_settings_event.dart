import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherSettingsEvent extends Equatable {
  const WeatherSettingsEvent();
}

class GetWeatherSettings extends WeatherSettingsEvent {
  @override
  List<Object> get props => null;
}

class UpdateWeatherSettings extends WeatherSettingsEvent {
  final bool isWeatherCardEnabled;
  final String city;

  UpdateWeatherSettings(
      {@required this.isWeatherCardEnabled, @required this.city});

  @override
  List<Object> get props => [isWeatherCardEnabled, city];
}
