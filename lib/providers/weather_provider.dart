import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_api_service.dart';
import '../utils/storage_helper.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? currentWeather;
  Map<String, List<WeatherModel>> groupedForecast = {};
  String errorMessage = '';

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
    try{
      currentWeather = await _apiService.fetchCurrentWeather(city);
      errorMessage = '';
      notifyListeners();
    }
    catch(e){
      errorMessage = 'Failed to fetch weather data';
      currentWeather = null;
      notifyListeners();
    }
    notifyListeners();

  }

  Future<void> get5DayForecast(String city) async {
    try{
      groupedForecast = await _apiService.fetch5DayForecast(city);
      errorMessage = '';

      notifyListeners();
    }
    catch(e){
      errorMessage = 'Failed to fetch weather data';
      notifyListeners();
    }
    notifyListeners();
  }
}