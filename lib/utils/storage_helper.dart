import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCitiesStorage {
  static const _key = 'favoriteCities';

  Future<List<String>> loadFavoriteCities() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> saveFavoriteCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = await loadFavoriteCities();
    if (!favorites.contains(city)) {
      favorites.add(city);
      await prefs.setStringList(_key, favorites);
    }
  }

  Future<void> removeFavoriteCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = await loadFavoriteCities();
    favorites.remove(city);
    await prefs.setStringList(_key, favorites);
  }
}
