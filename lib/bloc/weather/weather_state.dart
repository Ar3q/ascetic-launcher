import 'package:ascetic_launcher/models/weather/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();
}

class InitialWeatherState extends WeatherState {
  @override
  List<Object> get props => null;
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => null;
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({@required this.weather})
      : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  @override
  List<Object> get props => null;
}

class NotConnectedToNetwork extends WeatherState {
  @override
  List<Object> get props => null;
}