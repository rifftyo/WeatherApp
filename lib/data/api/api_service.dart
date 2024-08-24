import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/weather_results.dart';

class ApiService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '64d891c551c484b47a25849f6f850f45';

  Future<WeatherResults> getWeather(String city) async {
    final response =
        await http.get(Uri.parse("$_baseUrl?q=$city&appid=$_apiKey"));
    if (response.statusCode == 200) {
      return WeatherResults.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load Weather Result'
      );
    }
  }
}
