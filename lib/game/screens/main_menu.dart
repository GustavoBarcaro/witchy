import 'package:flutter/material.dart';

import 'package:witchy/game/screens/game_play.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('WITCHY',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Press Start 2P',
                fontSize: 50,
                color: Color.fromARGB(255, 37, 37, 37),
                shadows: <Shadow>[
                  Shadow(
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const GamePlay(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 90, 187, 88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text('START GAME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Press Start 2P',
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
                  child: const Text('CREDITS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Press Start 2P',
                        fontSize: 24,
                        color: Colors.black,
                      )))),
        ],
      )),
    );
  }
}
