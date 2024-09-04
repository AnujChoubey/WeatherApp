import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class CityTile extends StatelessWidget {
  final String city;

  CityTile({required this.city});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    bool isFavorite = weatherProvider.favoriteCities.contains(city);

    return ListTile(
      tileColor: Theme.of(context).cardColor.withOpacity(0.2),
      title: Text(city,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),),
      trailing: IconButton(
        icon: Icon(isFavorite ? Icons.star : Icons.star_border,color: Colors.amber,),
        onPressed: () {
          if (isFavorite) {
            weatherProvider.removeFavoriteCity(city);
          } else {
            weatherProvider.addFavoriteCity(city);
          }
        },
      ),
    );
  }
}
