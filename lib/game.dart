// ignore_for_file: avoid_function_literals_in_foreach_calls

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
import 'package:witchy/game/model/game_data.dart';

import 'package:witchy/game/background.dart';
import 'package:witchy/game/card_display.dart';

class WitchyGame extends FlameGame with HasTappables {
  final Background _background = Background();
  final CardsDisplay _cardDisplay = CardsDisplay();
  final UpgradesDisplay _upgradeDisplay = UpgradesDisplay();
  final ActionButton _actionButton = ActionButton();
  final UpgradeButton _upgradeButton = UpgradeButton();

  // final AttackCard _attackCard = AttackCard();
  // final LifeCard _lifeCard = LifeCard();
  // final MagicCard _magicCard = MagicCard();

  final Player _player = Player();
  final Hud _hud = Hud(priority: 1);

  final List enemies = [Slime(), Eye(), Ghost()];

  final playerData = PlayerData();
  final gameData = GameData();

  final random = Random();

  bool actionsActive = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_hud);
    await add(_background);
    await add(_cardDisplay);
    await add(_player);
    await add(_actionButton);
    await add(_upgradeButton);
    startGame();
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  // }

  void startGame() {
    removeAll(gameData.enemies.value);
    gameData.enemies.value = gameData.generateRandomEnemies();
    gameData.enemies.value.forEach((element) async {
      await add(element);
    });
    removeAll(gameData.cards.value);
    gameData.cards.value = gameData.generateRandomCards();
    gameData.cards.value.forEach((element) async {
      await add(element);
    });
  }

  SpriteAnimationComponent getRandomEnemy() {
    return gameData.enemies.value[random.nextInt(3)];
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
    if (actionsActive == false) {
      _actionButton.selectThis();
      _upgradeButton.unselectThis();
      remove(_upgradeDisplay);
      add(_cardDisplay);
      gameData.cards.value.forEach((element) async {
        await add(element);
      });
      actionsActive = true;
    }
  }

  void activeUpgrades() {
    if (actionsActive == true) {
      _upgradeButton.selectThis();
      _actionButton.unselectThis();
      add(_upgradeDisplay);
      remove(_cardDisplay);
      removeAll(gameData.cards.value);
      actionsActive = false;
    }
  }

  void updateCards(row) async {
    remove(gameData.cards.value[row]);
    gameData.replaceCard(row);
    await add(gameData.cards.value[row]);
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
