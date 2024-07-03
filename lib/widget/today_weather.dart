import 'package:flutter/material.dart';

class TodayWeather extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  const TodayWeather({required this.weatherData, super.key});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Weather data is not available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    String description = weatherData!['weather'][0]['description'];
    double temperature = weatherData!['main']['temp'];
    String cityName = weatherData!['name'];
    int humidity = weatherData!['main']['humidity'];
    double windSpeed = weatherData!['wind']['speed'];
    int precipitation = weatherData!['clouds']['all'];

    // Convert the timestamp to a readable format
    var timestamp =
        DateTime.fromMillisecondsSinceEpoch(weatherData!['dt'] * 1000);
    String formattedDate =
        '${timestamp.day} ${_getMonthName(timestamp.month)} ${timestamp.year} | ${_formatTime(timestamp)}';

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            cityName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$temperature\u00B0\n',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                TextSpan(
                  text: formattedDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 65, top: 15, right: 65, bottom: 15),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWeatherInfoItem(Icons.beach_access_outlined,
                        '$precipitation%', 'Precipitation'),
                    _buildWeatherInfoItem(
                        Icons.water_drop, '$humidity%', 'Humidity'),
                    _buildWeatherInfoItem(Icons.air_outlined,
                        '${windSpeed.toStringAsFixed(1)} km/h', 'Wind Speed'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfoItem(IconData icon, String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String _formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
