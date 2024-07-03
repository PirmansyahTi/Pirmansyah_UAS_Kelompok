import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_provider.dart';
import '../widget/navbar.dart';
import '../widget/today_weather.dart';
import '../widget/widget_list_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeather('Jakarta');

    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeatherForMultipleCities(
            ['Jakarta', 'Bandung', 'Tangerang', 'Bogor', 'Sukabumi']);
  }

  void _searchCity() {
    String city = _cityController.text;
    if (city.isNotEmpty) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 81, 68, 255),
          child: Column(
            children: [
              const Navbar(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: 'Enter city name',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: _searchCity,
                    ),
                  ],
                ),
              ),
              Consumer<WeatherProvider>(
                builder: (context, weatherProvider, child) {
                  if (weatherProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (weatherProvider.weatherData != null) {
                    return Column(
                      children: [
                        TodayWeather(weatherData: weatherProvider.weatherData!),
                        WidgetListWeather(), // Pass weatherData here
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Failed to load weather data',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
