import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_keys.dart';
import '../models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherApiService {
  Future<WeatherModel?> fetchCurrentWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$openWeatherMapApiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel(
          cityName: data['name'],
          temp: data['main']['temp'],
          tempMin: data['main']['temp_min'],
          tempMax: data['main']['temp_max'],
          description: data['weather'][0]['description'],
          icon: data['weather'][0]['icon'],
          humidity: data['main']['humidity'],
          windSpeed: data['wind']['speed'],
          dateTime: DateTime.now(),  // Use the current time for the current weather
        );
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }


  Future<Map<String, List<WeatherModel>>> fetch5DayForecast(String city) async {
    final currentWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$openWeatherMapApiKey&units=metric';

    try {
      final currentWeatherResponse = await http.get(Uri.parse(currentWeatherUrl));
      if (currentWeatherResponse.statusCode != 200) {
        throw Exception('Failed to load current weather');
      }

      final currentWeatherData = json.decode(currentWeatherResponse.body);
      final lat = currentWeatherData['coord']['lat'];
      final lon = currentWeatherData['coord']['lon'];

      // Fetch 5-day forecast
      final forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$openWeatherMapApiKey&units=metric';
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (forecastResponse.statusCode == 200) {
        final forecastData = json.decode(forecastResponse.body);
        final Map<String, List<WeatherModel>> groupedForecast = {};

        // Group forecast by day
        for (var item in forecastData['list']) {
          final dtTxt = item['dt_txt'];  // Format: "2024-09-04 09:00:00"
          final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(dtTxt));

          // Create WeatherModel from each forecast item
          final weather = WeatherModel(
            cityName: city,
            temp: double.parse(item['main']['temp'].toString()),
            tempMin: double.parse(item['main']['temp_min'].toString()),
            tempMax: double.parse(item['main']['temp_max'].toString()),
            description: item['weather'][0]['description'],
            icon: item['weather'][0]['icon'],
            humidity: item['main']['humidity'],
            windSpeed: double.parse(item['wind']['speed'].toString()),
            dateTime: DateTime.parse(dtTxt),  // Save the exact date and time
          );

          // Add to grouped forecast
          if (groupedForecast.containsKey(date)) {
            groupedForecast[date]?.add(weather);
          } else {
            groupedForecast[date] = [weather];
          }
        }

        return groupedForecast;
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }

}
