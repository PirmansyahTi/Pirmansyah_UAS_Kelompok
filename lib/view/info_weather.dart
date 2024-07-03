import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_provider.dart';

class InfoWeather extends StatefulWidget {
  const InfoWeather({super.key});

  @override
  State<InfoWeather> createState() => _InfoWeatherState();
}

class _InfoWeatherState extends State<InfoWeather> {
  @override
  void initState() {
    super.initState();
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider
        .fetchWeather('Jakarta'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 81, 68, 255),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 35, right: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    const Text(
                      "7 Days",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text("")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blueAccent,
                          Color.fromARGB(255, 14, 145, 252),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blueAccent,
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Consumer<WeatherProvider>(
                      builder: (context, weatherProvider, child) {
                        if (weatherProvider.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (weatherProvider
                            .weeklyWeatherData.isNotEmpty) {
                          return Column(
                            children: [
                              // Example for current day's detailed weather
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                      "assets/images/cloudy_wheater.png"),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "${weatherProvider.weeklyWeatherData[0]['temp']['day']}\u00B0",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "/ ${weatherProvider.weeklyWeatherData[0]['temp']['night']}\u00B0\n",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Additional weather details
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(Icons.beach_access,
                                            color: Colors.white),
                                        Text(
                                          "${weatherProvider.weeklyWeatherData[0]['pop'] * 100}%",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const Text("Precipitation",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(Icons.water_drop,
                                            color: Colors.white),
                                        Text(
                                          "${weatherProvider.weeklyWeatherData[0]['humidity']}%",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text("Humidity",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(Icons.air_outlined,
                                            color: Colors.white),
                                        Text(
                                          "${weatherProvider.weeklyWeatherData[0]['wind_speed']}km/h",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text("Wind Speed",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: Text('Failed to load weather data',
                                  style: TextStyle(color: Colors.white)));
                        }
                      },
                    ),
                  ),
                ),
                Consumer<WeatherProvider>(
                  builder: (context, weatherProvider, child) {
                    if (weatherProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (weatherProvider.weeklyWeatherData.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: weatherProvider.weeklyWeatherData.length,
                        itemBuilder: (context, index) {
                          final dayWeather =
                              weatherProvider.weeklyWeatherData[index];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Day ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          'http://openweathermap.org/img/wn/${dayWeather['weather'][0]['icon']}@2x.png',
                                          width: 45,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          dayWeather['weather'][0]
                                              ['description'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${dayWeather['temp']['day']}\u00B0",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${dayWeather['temp']['max']}\u00B0",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                          child: Text('Failed to load weather data',
                              style: TextStyle(color: Colors.white)));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
