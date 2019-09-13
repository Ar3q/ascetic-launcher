class Sys {
  final DateTime sunrise;
  final DateTime sunset;
  final String country;

  Sys({this.sunrise, this.sunset, this.country});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sunrise']*1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sunset']*1000),
      country: json['country'],
    );
  }
}
