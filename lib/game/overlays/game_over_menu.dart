// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text('YOU DIED',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Press Start 2P',
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
              gameRef.reset();
              gameRef.resumeEngine();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 90, 187, 88),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'REINCARNATE',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Press Start 2P',
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
