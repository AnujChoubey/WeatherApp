import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_api_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? currentWeather;
  Map<String, List<WeatherModel>> groupedForecast = {};

  WeatherApiService _apiService = WeatherApiService();

  // Fetch the current weather
  Future<void> getCurrentWeather(String city) async {
    currentWeather = await _apiService.fetchCurrentWeather(city);
    notifyListeners();
  }

  // Fetch the 5-day forecast and group it by date
  Future<void> get5DayForecast(String city) async {
    groupedForecast = await _apiService.fetch5DayForecast(city);
    notifyListeners();
  }
}