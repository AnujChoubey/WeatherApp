import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_api_service.dart';
import '../utils/storage_helper.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? currentWeather;
  Map<String, List<WeatherModel>> groupedForecast = {};

  WeatherApiService _apiService = WeatherApiService();
  FavoriteCitiesStorage storage = FavoriteCitiesStorage();
  List<String> favoriteCities = [];

  WeatherProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    favoriteCities = await storage.loadFavoriteCities();
    notifyListeners();
  }

  Future<void> addFavoriteCity(String city) async {
    await storage.saveFavoriteCity(city);
    await loadFavorites();
  }

  Future<void> removeFavoriteCity(String city) async {
    await storage.removeFavoriteCity(city);
    await loadFavorites();
  }

  Future<void> getCurrentWeather(String city) async {
    currentWeather = await _apiService.fetchCurrentWeather(city);
    notifyListeners();
  }

  Future<void> get5DayForecast(String city) async {
    groupedForecast = await _apiService.fetch5DayForecast(city);
    notifyListeners();
  }
}