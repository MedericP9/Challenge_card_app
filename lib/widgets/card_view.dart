import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardView extends StatelessWidget {
  final CardModel card;

  const CardView({required this.card, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPremium = card.pack == "premium";

    return Container(

      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPremium
              ? [Color(0xFFFFD54F), Color(0xFFFFA000)]
              : [Colors.white, Color(0xFFF3F4F8)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Badge Premium
          if (isPremium)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "PREMIUM",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                card.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                card.text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
