import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
 
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
 
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}
 
class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
 
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;
 
  Future<void> _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
 
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
        _weather = null;
      });
    }
  }
 
  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.trim().isNotEmpty) {
                      _fetchWeather(_cityController.text.trim());
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) _fetchWeather(value.trim());
              },
            ),
            const SizedBox(height: 24),
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            if (_weather != null) ...[
              Text(
                _weather!.cityName,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                '${_weather!.temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(fontSize: 48),
              ),
              Text(_weather!.description),
              const SizedBox(height: 8),
              Text('Humidity: ${_weather!.humidity.toStringAsFixed(0)}%'),
              Text('Wind: ${_weather!.windSpeed.toStringAsFixed(1)} m/s'),
            ],
          ],
        ),
      ),
    );
  }
}