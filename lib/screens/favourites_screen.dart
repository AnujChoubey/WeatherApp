import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/common.dart';
import '../providers/weather_provider.dart';

class FavoritesScreen extends StatefulWidget {
  final bool isDarkMode;

  FavoritesScreen({required this.isDarkMode});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: widget.isDarkMode
                ? Image.asset(
                    'assets/images/night_city.jpeg',
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/sky_omg.jpeg',
                    fit: BoxFit.cover,
                  ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            FocusScope.of(context).unfocus();

                          },
                          child: Icon(Icons.arrow_back)),
                      Text(
                        "Favorite Cities",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 21, fontWeight: FontWeight.w700),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: weatherProvider.favoriteCities.length,
                  itemBuilder: (context, index) {
                    String city = weatherProvider.favoriteCities[index];
                    return Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: widget.isDarkMode?Colors.white.withOpacity(0.4):Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        title: Text(city),
                        onTap: () {
                          weatherProvider.removeFavoriteCity(city);
                          CommonHelper().showToast(context,'Deleted from favourites');
                        },
                        trailing: Icon(Icons.delete,color: Colors.red,),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
