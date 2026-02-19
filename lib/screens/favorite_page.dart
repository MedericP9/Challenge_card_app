import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../services/card_service.dart';
import '../models/card_model.dart';
import '../widgets/card_view.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<int> favoriteIds = [];
  List<CardModel> favoriteCards = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    favoriteIds = await StorageService.getFavorites();
    final cardService = CardService();
    await cardService.loadCards();
    favoriteCards = cardService.allCards.where((c) => favoriteIds.contains(c.id)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: favoriteCards.isEmpty
          ? const Center(child: Text('Aucun favori pour l’instant'))
          : ListView.builder(
          itemCount: favoriteCards.length,
          itemBuilder: (context, index) {
            return CardView(card: favoriteCards[index]);
            },
            ),
    );
  }
}