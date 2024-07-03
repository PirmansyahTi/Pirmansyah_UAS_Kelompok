import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_provider.dart';
import '../view/info_weather.dart';

class WidgetListWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> weatherList =
        Provider.of<WeatherProvider>(context).multipleCitiesWeatherData;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
              Row(
                children: [
                  const Text(
                    '7 Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InfoWeather();
                          },
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> weather = weatherList[index];
                  double temperature = weather['main']['temp'];
                  String description = weather['weather'][0]['description'];
                  String cityName = weather['name'];
                  // Adjust this part based on your weather data structure

                  return Container(
                    width: 100,
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          cityName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          '$temperature°C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
