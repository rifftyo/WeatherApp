import 'package:flutter/material.dart';
import 'package:weather_app/data/api/api_service.dart';
import 'package:weather_app/data/model/weather_results.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherResults> _weather;

  @override
  void initState() {
    super.initState();
    _weather = ApiService().getWeather('jakarta');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<WeatherResults>(
          future: _weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final weatherData = snapshot.data!.weather.first;
              final tempCelcius = snapshot.data!.main.temp - 273.15;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, size: 35),
                      const SizedBox(width: 5),
                      Text(
                        snapshot.data!.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                  Image.network(
                      'https://openweathermap.org/img/wn/${weatherData.icon}@4x.png'),
                  Text(
                    '${tempCelcius.toStringAsFixed(0)} °C',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    weatherData.main,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              );
            } else {
              return const Text('No Data Found');
            }
          },
        ),
      ),
    );
  }
}
