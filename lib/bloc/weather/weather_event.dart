import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String city;

  GetWeather({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
