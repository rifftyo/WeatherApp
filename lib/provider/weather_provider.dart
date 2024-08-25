import 'package:flutter/material.dart';
import 'package:weather_app/data/api/api_service.dart';
import 'package:weather_app/data/model/weather_results.dart';

enum ResultState { loading, noData, hasData, error }

class WeatherProvider extends ChangeNotifier {
  final ApiService apiService;

  WeatherProvider({required this.apiService}) {
    _fetchWeather('Sleman');
  }

  late WeatherResults _weatherResults;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  WeatherResults get result => _weatherResults;

  ResultState get state => _state;

  Future<dynamic> _fetchWeather(String cityName) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final weather = await apiService.getWeather(cityName);
      if (weather.name.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'City Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _weatherResults = weather;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}