// TODO Implement this library.
class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final double humidity;
  final double windSpeed;
 
  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
  });
 
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
 