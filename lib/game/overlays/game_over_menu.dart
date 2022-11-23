import 'package:flutter/material.dart';

import 'package:witchy/game.dart';

class GameOverMenu extends StatelessWidget {
  static const id = 'GameOverMenu';
  final WitchyGame gameRef;

  const GameOverMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(100),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text('YOU DIED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 40,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () {
              gameRef.overlays.remove(id);
              gameRef.resumeEngine();
              gameRef.reset();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 90, 187, 88),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'REINCARNATE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
