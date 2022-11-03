import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:witchy/game.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';
  final WitchyGame gameRef;

  const MainMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('WITCHY',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Press Start 2P',
                fontSize: 50,
                color: const Color.fromARGB(255, 37, 37, 37),
                shadows: <Shadow>[
                  const Shadow(
                      blurRadius: 30.0,
                      color: Colors.white,
                      offset: Offset(0, 0)),
                ],
              )),
          const SizedBox(height: 150),
          SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    gameRef.overlays.remove(id);
                    gameRef.add(WitchyGame());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 90, 187, 88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text('START GAME',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Press Start 2P',
                        fontSize: 24,
                      )))),
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text('CREDITS',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Press Start 2P',
                        fontSize: 24,
                        color: Colors.black,
                      )))),
        ],
      )),
    );
  }
}
