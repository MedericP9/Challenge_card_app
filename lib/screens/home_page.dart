import 'package:flutter/material.dart';
import '../services/card_service.dart';
import '../widgets/swipe_card.dart';
import 'favorite_page.dart';
import '../widgets/card_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final CardService cardService = CardService();
  bool loading = true;
  bool _isAdvancing = false;

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
    await cardService.loadCards();
    setState(() => loading = false);
  }

  void handleSwipe(bool liked) async {
    await cardService.swipeCard(liked);

    if (!cardService.hasNext()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plus de cartes !')),
      );
      return;
    }

    setState(() {
      _isAdvancing = true;
    });

    await Future.delayed(const Duration(milliseconds: 250));

    setState(() {
      cardService.showNext();
      _isAdvancing = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentCard = cardService.getCurrentCard();
    final hasNext = cardService.hasNext();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Défis Cartes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FavoritesPage(),
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF667EEA),
              Color(0xFF764BA2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),

            // 🃏 Stack effet Tinder
            Expanded(
              child: Center(
                child: 
                Stack(
                  alignment: Alignment.center,
                  children: [

                    if (hasNext)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 20),
                        curve: Curves.easeOut,
                        transform: Matrix4.identity()
                          ..translate(0.0, _isAdvancing ? 0.0 : -12.0)
                          ..scale(_isAdvancing ? 1.0 : 0.96),
                        child: Opacity(
                          opacity: 0.9,
                          child: CardView(
                            card: cardService.getNextCardPreview(),
                          ),
                        ),
                      ),

                    SwipeCard(
                      key: ValueKey<int>(currentCard.id),
                      card: currentCard,
                      onSwipe: handleSwipe,
                    ),
                  ],
                ),

              ),
            ),

            // 📊 Compteur progression
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                "${cardService.currentIndex + 1} / ${cardService.totalCards}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
