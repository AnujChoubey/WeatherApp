import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../widgets/forecast_card.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  HomeScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false)
        .getCurrentWeather('Bengaluru');
    Provider.of<WeatherProvider>(context, listen: false)
        .get5DayForecast('Bengaluru');
    _controller.text = 'Bengaluru'; // Pre-fill the search bar with 'Bengaluru'
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: widget.isDarkMode
                ? Image.asset(
                    'assets/images/night_sky.jpeg',
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    'assets/images/sky_omg.jpeg',
                    fit: BoxFit.cover,
                  ),
          ),

          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Weather App',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 21, fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.brightness_6,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: widget.toggleTheme,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter city name',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 14),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          weatherProvider.getCurrentWeather(_controller.text);
                          weatherProvider.get5DayForecast(_controller.text);
                        },
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      weatherProvider.getCurrentWeather(_controller.text);
                      weatherProvider.get5DayForecast(_controller.text);
                    },
                    //TODO: Api call can be put onChanged but since there is a limit to free API , discarding it.
                  ),
                ),
                SizedBox(height: 20),
                weatherProvider.currentWeather != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WeatherCard(
                                weather: weatherProvider.currentWeather!)
                            .animate()
                            .fadeIn(),
                      )
                    : Text('Fetching weather data...'),
                SizedBox(height: 20),
                weatherProvider.currentWeather == null
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: weatherProvider.groupedForecast.length,
                          itemBuilder: (context, index) {
                            String date = weatherProvider.groupedForecast.keys
                                .elementAt(index);
                            List<WeatherModel> dailyForecast =
                                weatherProvider.groupedForecast[date]!;
                            return ForecastCard(
                              date: date,
                              dailyForecast: dailyForecast,
                            ).animate().fadeIn();
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
