import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/api/api_service.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(apiService: ApiService()),
      child: Scaffold(
        body: Consumer<WeatherProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              final weatherData = state.result.weather.first;
              final tempKelvin = state.result.main.temp;
              final tempCelcius = tempKelvin - 273.15;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, size: 35),
                      const SizedBox(width: 5),
                      Text(
                        state.result.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weatherData.icon}@4x.png',
                  ),
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
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
        floatingActionButton: Consumer<ThemeProvider>(
          builder: (context, theme, _) {
            return FloatingActionButton(
              onPressed: () {
                theme.toggleTheme();
              },
              child: theme.isDark
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode),
            );
          },
        ),
      ),
    );
  }
}
