import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:witchy/components/lightning_attack.dart';
import 'package:witchy/components/main_menu.dart';

import 'package:witchy/model/player_data.dart';

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

  final game = WitchyGame();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Witchy',
    home: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GameWidget<WitchyGame>(
            game: kDebugMode ? WitchyGame() : game,
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

  // final Slime _enemySlime = Slime();
  // final Eye _enemyEye = Eye();
  // final Ghost _enemyGhost = Ghost();

  final List enemies = [Slime(), Eye(), Ghost()];

  final playerData = PlayerData();

  final random = Random();

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
    enemies.forEach((element) async {
      await add(element);
    });
    //   await add(_enemySlime);
    //   await add(_enemyEye);
    //   await add(_enemyGhost);
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  // }

  SpriteAnimationComponent getRandomEnemy() {
    return enemies[random.nextInt(3)];
  }

  void physicAttack() async {
    final SpriteAnimationComponent enemy = getRandomEnemy();
    final originalPosition = Vector2(16.0, size[1] / 2.0 - 96.0);

    _player.size = Vector2.all(172);
    _player.priority = 1;
    _player.anchor = Anchor.center;
    _player.position =
        Vector2(enemy.position.x - enemy.size.x / 2, enemy.position.y);
    _player.playMeleeAnimation();
    await Future.delayed(const Duration(seconds: 1), () {
      _player.size = Vector2.all(128);
      _player.position = originalPosition;
      _player.anchor = Anchor.topLeft;
      _player.playIdleAnimation();
    });
  }

  void magicAttack() async {
    final SpriteAnimationComponent enemy = getRandomEnemy();
    _player.size = Vector2.all(160);
    _player.playMagicAnimation();
    await Future.delayed(const Duration(milliseconds: 750), () {
      add(LightningAttack(
          position:
              Vector2(enemy.position.x, enemy.position.y - enemy.size.y)));
    });
    await Future.delayed(const Duration(milliseconds: 750), () {
      _player.size = Vector2.all(128);
      _player.playIdleAnimation();
    });
  }
}
