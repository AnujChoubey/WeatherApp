class WeatherModel {
  final String cityName;
  final double temp;
  final String description;
  final double tempMin;
  final double tempMax;
  final DateTime dateTime;
  final String icon;
  final int humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.description,
    required this.tempMin,
    required this.tempMax,
    required this.dateTime,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      dateTime: DateTime.parse(json['main']['dt_text']),
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
