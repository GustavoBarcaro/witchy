import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:witchy/game/actors/eye.dart';
import 'package:witchy/game/actors/ghost.dart';
import 'package:witchy/game/actors/player.dart';
import 'package:witchy/game/actors/slime.dart';

import 'package:witchy/game/overlays/hud.dart';

import 'package:witchy/game/model/player_data.dart';

import 'package:witchy/game/attack_card.dart';
import 'package:witchy/game/background.dart';
import 'package:witchy/game/card_display.dart';
import 'package:witchy/game/life_card.dart';
import 'package:witchy/game/magic_card.dart';

class WitchyGame extends FlameGame with HasTappables {
  final Background _background = Background();
  final CardsDisplay _cardDisplay = CardsDisplay();
  final UpgradesDisplay _upgradeDisplay = UpgradesDisplay();
  final ActionButton _actionButton = ActionButton();
  final UpgradeButton _upgradeButton = UpgradeButton();

  final AttackCard _attackCard = AttackCard();
  final LifeCard _lifeCard = LifeCard();
  final MagicCard _magicCard = MagicCard();

  final Player _player = Player();
  final Hud _hud = Hud(priority: 1);

  final List enemies = [Slime(), Eye(), Ghost()];

  final playerData = PlayerData();

  final random = Random();

  bool attack = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_hud);
    await add(_background);
    await add(_cardDisplay);
    // await add(_upgradeDisplay);
    await add(_attackCard);
    await add(_lifeCard);
    await add(_magicCard);
    await add(_player);
    // ignore: avoid_function_literals_in_foreach_calls
    enemies.forEach((element) async {
      await add(element);
    });
    await add(_actionButton);
    await add(_upgradeButton);
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
    _player.meleeAttack(enemy);
  }

  void magicAttack() async {
    final SpriteAnimationComponent enemy = getRandomEnemy();
    _player.magicAttack(enemy);
  }

  void activeActions() {
    _actionButton.selectThis();
    _upgradeButton.unselectThis();
    remove(_upgradeDisplay);
  }

  void activeUpgrades() {
    _upgradeButton.selectThis();
    _actionButton.unselectThis();
    add(_upgradeDisplay);
  }
}

class ActionButton extends SpriteComponent
    with HasGameRef<WitchyGame>, Tappable {
  late final Sprite pressed;
  late final Sprite unpressed;

  @override
  Future<void>? onLoad() async {
    pressed = await gameRef.loadSprite('buttons/actions_button_pressed.png');
    unpressed =
        await gameRef.loadSprite('buttons/actions_button_unpressed.png');
    sprite = pressed;
    size = Vector2(gameRef.size.x / 2, 50);
    position = Vector2(0, gameRef.size.y - (gameRef.size.x / 2) - 50);
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.activeActions();
    return false;
  }

  void selectThis() {
    sprite = pressed;
  }

  void unselectThis() {
    sprite = unpressed;
  }
}

class UpgradeButton extends SpriteComponent
    with HasGameRef<WitchyGame>, Tappable {
  late final Sprite pressed;
  late final Sprite unpressed;

  @override
  Future<void>? onLoad() async {
    pressed = await gameRef.loadSprite('buttons/upgrades_button_pressed.png');
    unpressed =
        await gameRef.loadSprite('buttons/upgrades_button_unpressed.png');
    sprite = unpressed;
    size = Vector2(gameRef.size.x / 2, 50);
    position =
        Vector2(gameRef.size.x / 2, gameRef.size.y - (gameRef.size.x / 2) - 50);
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.activeUpgrades();
    return false;
  }

  void selectThis() {
    sprite = pressed;
  }

  void unselectThis() {
    sprite = unpressed;
  }
}

class UpgradesDisplay extends PositionComponent with HasGameRef<WitchyGame> {
  UpgradesDisplay({super.priority});

  @override
  Future<void>? onLoad() {
    position = Vector2(0.0, gameRef.size[1] - (gameRef.size[0] / 2.0));
    size = Vector2(gameRef.size[0], gameRef.size[0] / 2.0);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(),
        Paint()..color = const Color.fromARGB(255, 140, 170, 222));
  }
}
