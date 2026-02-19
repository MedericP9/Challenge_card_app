import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/card_model.dart';
import 'storage_service.dart';

class CardService {
  List<CardModel> allCards = [];
  int currentIndex = 0;

  Future<void> loadCards() async {
    final data = await rootBundle.loadString('lib/data/cards.json');
    final List<dynamic> jsonList = json.decode(data);
    allCards = jsonList.map((json) => CardModel.fromJson(json)).toList();

    final disliked = await StorageService.getDisliked();
    allCards.removeWhere((card) => disliked.contains(card.id));
    allCards.shuffle();
  }

  CardModel getCurrentCard() => allCards[currentIndex];
  
  Future<void> swipeCard(bool liked) async 
  {
    final currentCard = allCards[currentIndex];
    if (liked) {
      await StorageService.addFavorite(currentCard.id);
    } else {
      await StorageService.addDisliked(currentCard.id);
    }
    currentCard.judged = true;

  }
  bool hasNext() => currentIndex + 1 < allCards.length; 
  void showNext() {
    if (hasNext()) {
      currentIndex++;
    }
  }

}