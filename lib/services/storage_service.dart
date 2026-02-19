import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String favoritesKey = 'favorites';
  static const String dislikedKey = 'disliked';
  static const String premiumKey = 'premium_packs';

  static Future<List<int>> getFavorites()
      async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoritesKey)?.map(int.parse).toList() ?? [];
  }

  static Future<void> addFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = await getFavorites();
    if (!favs.contains(id)) {
      favs.add(id);
      await prefs.setStringList(favoritesKey, favs.map((e) => e.toString()).toList());
    }
  }

  static Future<List<int>> getDisliked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(dislikedKey)?.map(int.parse).toList() ?? [];
  }

  static Future<void> addDisliked(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final disliked = await getDisliked();
    if (!disliked.contains(id)) {
      disliked.add(id);
      await prefs.setStringList(dislikedKey, disliked.map((e) => e.toString()).toList());
    }
  }

  static Future<List<String>> getPremiumPacks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(premiumKey) ?? [];
  }

  static Future<void> addPremiumPack(String packId) async {
    final prefs = await SharedPreferences.getInstance();
    final packs = await getPremiumPacks();
    if (!packs.contains(packId)) {
      packs.add(packId);
      await prefs.setStringList(premiumKey, packs);
    }
  }
}