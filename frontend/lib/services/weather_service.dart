import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
 
class WeatherService {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
 
  // TODO: replace with your real API key
  final String apiKey = 'YOUR_API_KEY_HERE';
 
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );
 
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else if (response.statusCode == 401) {
      throw Exception('Invalid or inactive API key');
    } else {
      throw Exception('Failed to load weather data (${response.statusCode})');
    }
  }
}