import 'package:flutter/material.dart';
import 'package:witchy/game.dart';
import 'package:witchy/game/screens/main_menu.dart';

class PauseMenu extends StatelessWidget {
  static const id = 'PauseMenu';
  final WitchyGame gameRef;

  const PauseMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(100),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 150,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    gameRef.overlays.remove(id);
                    gameRef.resumeEngine();
                  },
                  child: const Text(
                    'Resume',
                    style: TextStyle(fontSize: 24),
                  ))),
          SizedBox(
              width: 150,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    gameRef.overlays.remove(id);
                    gameRef.reset();
                    gameRef.resumeEngine();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MainMenu(gameRef: gameRef)));
                  },
                  child: const Text(
                    'Exit',
                    style: TextStyle(fontSize: 24),
                  ))),
        ],
      )),
    );
  }
}
