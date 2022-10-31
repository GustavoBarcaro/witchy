import 'package:flutter/material.dart';
import 'package:witchy/main.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';
  final WitchyGame gameRef;

  const MainMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    gameRef.add(WitchyGame());
                  },
                  child: const Text(
                    'Play',
                    style: TextStyle(fontSize: 24),
                  )))
        ],
      )),
    );
  }
}
