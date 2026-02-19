import 'package:flutter/material.dart';
import '../services/card_service.dart';
import '../widgets/swipe_card.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final CardService cardService = CardService();
  bool nextCardReady = false;
  bool loading = true;

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
    setState(() => nextCardReady = true);
  }

  void showNext() {
    setState((){
      if (cardService.hasNext()) {
          cardService.showNext();
          nextCardReady = false;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No more cards!')));
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Défis Cartes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage())),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwipeCard(
              key: ValueKey<int>(cardService.getCurrentCard().id),
              card: cardService.getCurrentCard(),  // ✅ la carte entière
              onSwipe: handleSwipe,
            ),            
            const SizedBox(height: 20),
            if (nextCardReady)
              ElevatedButton(onPressed: showNext, child: const Text('Prochain défis'),
              ),
          ],
        ),
      ),
    );
  }
}