import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:weather_app/view/widgets/pulsing_icon.dart';
import '../../models/weather_model.dart';

class ForecastCard extends StatelessWidget {
  final String date;
  final List<WeatherModel> dailyForecast;

  ForecastCard({required this.date, required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    final DateTime parsedDate = DateTime.parse(date);
    final String formattedDate = DateFormat('MMM d').format(parsedDate);

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.2),  // Semi-transparent card
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),  // Blur effect
          child: Container(
            padding: const EdgeInsets.only(left:0,right: 0,top: 8,bottom: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.2),  // Adjust opacity for visual effect
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Weather for $formattedDate',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const  SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: dailyForecast.map((weather) {
                      final String formattedHour = DateFormat('h a').format(weather!.dateTime);

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding:const  EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.withOpacity(0.4),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              formattedHour,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const  SizedBox(height: 4),
                            Text(
                              weather.description.toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                           PulsingIcon(iconUrl: 'http://openweathermap.org/img/wn/${weather.icon}@4x.png'),
                            Text(
                              'Temp: ${weather.temp}°C',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Min: ${weather.tempMin}°C',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Max: ${weather.tempMax}°C',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(),
        ),
      ),
    );
  }
}
