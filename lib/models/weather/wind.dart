class Wind {
  final double speed;

  Wind({this.speed});

  factory Wind.fromJson(Map<String, dynamic> json){
    return Wind(
      speed: json['speed'],
    );
  }
}