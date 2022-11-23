// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:math';

import 'package:flame/game.dart';

import 'package:witchy/game/actors/enemy.dart';
import 'package:witchy/game/actors/player.dart';

import 'package:witchy/game/components/coin_hud.dart';
import 'package:witchy/game/components/target.dart';

import 'package:witchy/game/model/player_data.dart';
import 'package:witchy/game/model/game_data.dart';

import 'package:witchy/game/overlays/game_over_menu.dart';

import 'package:witchy/game/screens/background.dart';
import 'package:witchy/game/screens/card_display.dart';

import 'game/components/eye_attack.dart';

class WitchyGame extends FlameGame with HasTappables {
  final Background _background = Background();
  final CardsDisplay _cardDisplay = CardsDisplay();

  final CoinIcon _coinIcon = CoinIcon();
  final CoinLabel _coinLabel = CoinLabel();

  final Player _player = Player();

  final playerData = PlayerData();
  final gameData = GameData();

  bool playerTurn = true;
  bool playerAttacking = false;
  bool enemyTurn = false;

  Target? target;

  @override
  Future<void> onLoad() async {
    await add(_background);
    await add(_cardDisplay);
    await add(_player);
    await add(_coinIcon);
    await add(_coinLabel);
    startGame();
    super.onLoad();
  }

  @override
  void update(double dt) {
    int fainted = 0;
    gameData.enemies.forEach((element) {
      if (element.health <= 0) fainted++;
    });
    if (fainted != 3) {
      if (playerTurn == false && enemyTurn == false) {
        enemyTurn = true;
        enemyAttack();
      }
    }

    if (fainted == 3) respawnEnemies();

    if (playerData.health.value <= 0) {
      pauseEngine();
      overlays.add(GameOverMenu.id);
    }

    super.update(dt);
  }

  void startGame() {
    resetPlayerData();
    resetGameData();
    gameData.enemies = gameData.generateRandomEnemies();
    addAll(gameData.enemies);

    gameData.cards = gameData.generateRandomCards();
    addAll(gameData.cards);

    gameData.hearts = gameData.fullHealth();
    addAll(gameData.hearts);

    playerData.health.removeListener(() {});

    playerData.health.addListener(() {
      updateHealthContainer(playerData.health.value);
    });
  }

  Enemy getRandomEnemy() {
    Enemy enemy = gameData.enemies[Random().nextInt(3)];
    if (enemy.health <= 0) {
      return getRandomEnemy();
    } else {
      return enemy;
    }
  }

  void physicAttack() async {
    final int minDamage = playerData.meleeMinDamage;
    final int maxDamage = playerData.meleeMaxDamage;
    final int damage = minDamage + Random().nextInt(maxDamage - minDamage);
    final Enemy? enemy = target?.enemy;
    _player.meleeAttack(enemy!, damage);
  }

  void magicAttack() async {
    final int minDamage = playerData.magicMinDamage;
    final int maxDamage = playerData.magicMaxDamage;
    final int damage = minDamage + Random().nextInt(maxDamage - minDamage);
    final Enemy? enemy = target?.enemy;
    _player.magicAttack(enemy!, damage);
  }

  void enemyAttack() {
    final Enemy enemy = getRandomEnemy();
    enemy.attackPlayer();
  }

  void healing() {
    if (playerData.health.value < 12) {
      playerData.health.value += playerData.healingPower;
    }
    playerTurn = false;
  }

  void updateCards(row) async {
    remove(gameData.cards[row]);
    gameData.replaceCard(row);
    await add(gameData.cards[row]);
  }

  void updateHealthContainer(health) {
    removeAll(gameData.hearts);
    gameData.updateHealth(health);
    addAll(gameData.hearts);
  }

  void removeTarget() {
    if (target != null) {
      remove(target!);
    }
    target = null;
  }

  void changeTarget(Enemy enemy) {
    removeTarget();
    target = Target(enemy: enemy);
    add(target!);
  }

  void respawnEnemies() {
    playerTurn = true;
    enemyTurn = false;
    gameData.enemies = gameData.generateRandomEnemies();
    Future.delayed(const Duration(seconds: 1), () {
      addAll(gameData.enemies);
    });
  }

  void resetGameData() {
    gameData.enemies = [];
    gameData.cards = [];
    gameData.hearts = [];
  }

  void resetPlayerData() {
    playerData.health.value = 12;
    playerData.coins.value = 0;
    playerData.meleeMinDamage = 3;
    playerData.meleeMaxDamage = 4;
    playerData.magicMinDamage = 1;
    playerData.magicMaxDamage = 6;
    playerData.healingPower = 2;
  }

  void reset() {
    gameData.enemies.forEach(((element) {
      if (element.health > 0) remove(element);
    }));
    removeTarget();
    removeAll(gameData.cards);
    removeAll(gameData.hearts);
    resetPlayerData();
    resetGameData();
    startGame();
  }

  void activeEyeLaser(Vector2 position) {
    add(EyeAttack()..position = Vector2(position.x, position.y + 16));
  }

  Vector2 getPlayerPosition() => _player.position;
}
