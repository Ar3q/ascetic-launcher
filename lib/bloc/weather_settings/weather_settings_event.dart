import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherSettingsEvent extends Equatable {
  WeatherSettingsEvent([List props = const <dynamic>[]]) : super(props);
}

class GetWeatherSettings extends WeatherSettingsEvent {}

class UpdateWeatherSettings extends WeatherSettingsEvent {
  final bool isWeatherCardEnabled;
  final String city;

  UpdateWeatherSettings(
      {@required this.isWeatherCardEnabled, @required this.city})
      : super([isWeatherCardEnabled, city]);
}
