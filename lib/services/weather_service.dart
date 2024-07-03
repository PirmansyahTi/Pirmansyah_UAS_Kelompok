import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String _apiKey = '72004848420056f2f944971d986b8d0c';
  static const String _currentWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _weeklyWeatherUrl = 'https://api.openweathermap.org/data/2.5/onecall';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$_currentWeatherUrl?q=$city&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<dynamic>> fetchWeeklyWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse('$_weeklyWeatherUrl?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['daily'];
    } else {
      throw Exception('Failed to load weekly weather');
    }
  }
}
