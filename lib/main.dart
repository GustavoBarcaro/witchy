import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:witchy/components/main_menu.dart';

import 'package:witchy/model/player_data.dart';

import 'components/command.dart';
import 'components/hud.dart';
import 'components/attack_card.dart';
import 'components/life_card.dart';
import 'components/magic_card.dart';
import 'components/background.dart';
import 'components/card_display.dart';
import 'components/eye.dart';
import 'components/ghost.dart';
import 'components/player.dart';
import 'components/slime.dart';

const spriteSize = 64.0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  final _game = WitchyGame();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Witchy',
    home: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GameWidget<WitchyGame>(
            game: kDebugMode ? WitchyGame() : _game,
            overlayBuilderMap: {
              MainMenu.id: ((context, game) => MainMenu(gameRef: game))
            },
            initialActiveOverlays: const [MainMenu.id],
          ),
          // MenuOverlay(game: game),
        ],
      ),
    ),
  ));
}

class MenuOverlay extends StatelessWidget {
  const MenuOverlay({super.key, required this.game});

  final WitchyGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/screen/cards_display.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class WitchyGame extends FlameGame with HasTappables {
  final Background _background = Background();
  final CardsDisplay _cardDisplay = CardsDisplay();

  final AttackCard _attackCard = AttackCard();
  final LifeCard _lifeCard = LifeCard();
  final MagicCard _magicCard = MagicCard();

  final Player _player = Player();

  final Slime _enemySlime = Slime();
  final Eye _enemyEye = Eye();
  final Ghost _enemyGhost = Ghost();

  final _random = Random();

  final _commandList = List<Command>.empty(growable: true);
  final _addLaterCommandList = List<Command>.empty(growable: true);

  final playerData = PlayerData();

  bool attack = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(Hud(priority: 1));
    await add(_background);
    await add(_cardDisplay);
    await add(_attackCard);
    await add(_lifeCard);
    await add(_magicCard);
    await add(_player);
    await add(_enemySlime);
    await add(_enemyEye);
    await add(_enemyGhost);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _commandList.forEach((command) {
      // components.forEach()
    });

    _commandList.clear();
    _commandList.addAll(_addLaterCommandList);
    _addLaterCommandList.clear();
  }

  void addCommand(Command command) {
    _addLaterCommandList.add(command);
  }
}
