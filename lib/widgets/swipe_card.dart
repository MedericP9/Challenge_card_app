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
        child: Stack(
          children: [
            _cardView(),

            // LIKE overlay
            Positioned(
              top: 40,
              left: 20,
              child: Opacity(
                opacity: _dragX > 50 ? (_dragX / 200).clamp(0, 1) : 0,
                child: Transform.rotate(
                  angle: -0.5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "LIKE",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // DISLIKE overlay
            Positioned(
              top: 40,
              right: 20,
              child: Opacity(
                opacity: _dragX < -50 ? (-_dragX / 200).clamp(0, 1) : 0,
                child: Transform.rotate(
                  angle: 0.5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "NOPE",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
