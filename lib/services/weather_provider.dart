import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  List<Map<String, dynamic>> _multipleCitiesWeatherData = [];
  List<dynamic> _weeklyWeatherData = [];

  Map<String, dynamic>? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get multipleCitiesWeatherData =>
      _multipleCitiesWeatherData;
  List<dynamic> get weeklyWeatherData => _weeklyWeatherData;

  void fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weatherData = await WeatherService().fetchWeather(city);
      if (_weatherData != null) {
        final lat = _weatherData!['coord']['lat'];
        final lon = _weatherData!['coord']['lon'];
        await fetchWeeklyWeather(lat, lon);
      }
    } catch (e) {
      _weatherData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherForMultipleCities(List<String> cities) async {
    _isLoading = true;
    _multipleCitiesWeatherData.clear();
    notifyListeners();

    try {
      for (String city in cities) {
        final weatherData = await WeatherService().fetchWeather(city);
        _multipleCitiesWeatherData.add(weatherData);
      }
    } catch (e) {
      _multipleCitiesWeatherData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeeklyWeather(double lat, double lon) async {
    _isLoading = true;
    _weeklyWeatherData.clear();
    notifyListeners();

    try {
      _weeklyWeatherData = await WeatherService().fetchWeeklyWeather(lat, lon);
    } catch (e) {
      _weeklyWeatherData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
