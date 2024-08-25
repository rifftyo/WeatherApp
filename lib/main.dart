import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/ui/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) {
        return MaterialApp(
          theme: theme.isDark ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          home: const HomePage(),
        );
      },
    );
  }
}
