import 'package:flutter/material.dart';
import '../models/card_model.dart';

class SwipeCard extends StatefulWidget {
  final CardModel card;
  final Function(bool) onSwipe;

  const SwipeCard({
    Key? key,
    required this.card,
    required this.onSwipe,
  }) : super(key: key);

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  double _dragX = 0;
  bool _isDragging = false;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX += details.delta.dx;
      _isDragging = true;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dragX > 120) {
      // Swipe droite
      setState(() => _dragX = 1000);
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.onSwipe(true);
      });
    } else if (_dragX < -120) {
      // Swipe gauche
      setState(() => _dragX = -1000);
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.onSwipe(false);
      });
    } else {
      // Revenir au centre
      setState(() {
        _dragX = 0;
      });
    }

    _isDragging = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(_dragX, 0, 0)
          ..rotateZ(_dragX * 0.0008),
        child: _cardView(),
      ),
    );
  }

  Widget _cardView() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300,
        height: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.card.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              widget.card.text,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
