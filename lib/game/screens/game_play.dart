import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:witchy/game.dart';
import 'package:witchy/game/overlays/game_over_menu.dart';

WitchyGame _witchyGame = WitchyGame();

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: GameWidget<WitchyGame>(
            game: _witchyGame,
            overlayBuilderMap: {
              GameOverMenu.id: ((context, game) => GameOverMenu(gameRef: game)),
            },
          ),
        ),
      ),
    );
  }
}
