import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/api/api_service.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/ui/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(apiService: ApiService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: HomePage(),
    );
  }
}
