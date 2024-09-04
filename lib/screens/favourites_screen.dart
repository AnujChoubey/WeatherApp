import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Cities"),
      ),
      body: ListView.builder(
        itemCount: weatherProvider.favoriteCities.length,
        itemBuilder: (context, index) {
          String city = weatherProvider.favoriteCities[index];
          return ListTile(
            title: Text(city),
            onTap: () {
              Navigator.pop(context, city);
              FocusScope.of(context).unfocus();

            },
          );
        },
      ),
    );
  }
}
