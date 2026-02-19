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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwipeCard(
                key: ValueKey<int>(cardService.getCurrentCard().id),
                card: cardService.getCurrentCard(),
                onSwipe: handleSwipe,
              ),
              const SizedBox(height: 20),
              if (nextCardReady)
                ElevatedButton(
                  onPressed: showNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Prochain défi"),
                ),
            ],
          ),
        ),
      ),

    );
  }
}