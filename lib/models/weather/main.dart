class Main {
  final double temp;
  final double pressure;
  final int humidity;

  Main({
    this.temp,
    this.pressure,
    this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      pressure: json['pressure'].toDouble(),
      humidity: json['humidity'],
    );
  }
}
