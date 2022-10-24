import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final game = WitchyGame();
  runApp(GameWidget(game: game));
}

class WitchyGame extends FlameGame {
  final Background _background = Background();
  final CardsDisplay _cardDisplay = CardsDisplay();

  final AttackCard _attackCard = AttackCard();
  final LifeCard _lifeCard = LifeCard();
  final MagicCard _magicCard = MagicCard();

  final Player _player = Player();

  final Slime _enemySlime = Slime();
  final Eye _enemyEye = Eye();
  final Ghost _enemyGhost = Ghost();

  @override
  Future<void> onLoad() async {
    super.onLoad();
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
}
