import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import '../../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  WeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    final timeFormatter = DateFormat('h:mm a');

    return Container(
      margin: const EdgeInsets.all(8.0),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Image.network(
                      'http://openweathermap.org/img/wn/${weather.icon}@4x.png').animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(duration: Duration(seconds: 4)),
                  title: Text(
                    '${weather.cityName} \n${weather.temp}°C',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${weather.description.toUpperCase()}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Min: ${weather.tempMin}°C'),
                      Text('Max: ${weather.tempMax}°C'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Humidity: ${weather.humidity}%'),
                      Text('Wind: ${weather.windSpeed} m/s'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}