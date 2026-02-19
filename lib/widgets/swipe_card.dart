import 'package:flutter/material.dart';
import '../models/card_model.dart';

class SwipeCard extends StatelessWidget {
  final CardModel card;
  final Function(bool) onSwipe;

  const SwipeCard({Key? key, required this.card, required this.onSwipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: _cardView(),
      feedback: Material(
        color: Colors.transparent,
        elevation: 5,
        child: _cardView(),
      ),
      childWhenDragging: Container(),
      onDragEnd: (details) {
        if (details.offset.dx > 0) {
          onSwipe(true); // Liked
        } else {
          onSwipe(false); // Disliked
        }
      },
    );
  }

  Widget _cardView() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 300,
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(card.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),

            SizedBox(height: 20),
            Text(card.text, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center,),
          ],
        ),
    ),
    );
  }
}