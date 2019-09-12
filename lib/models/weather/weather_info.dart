class WeatherInfo {
  final String icon;
  final String main;
  final String description;
  final int id;

  WeatherInfo({this.icon, this.main, this.description, this.id});

  factory WeatherInfo.fromJson(Map<String, dynamic> json){
    return WeatherInfo(
      icon: json['icon'],
      main: json['main'],
      description: json['description'],
      id: json['id'],
    );
  }

}