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
    playerData.health.addListener(() {
      updateHealthContainer(playerData.health.value);
    });
    super.onLoad();
  }

  @override
  void update(double dt) {
    int fainted = 0;
    gameData.enemies.value.forEach((element) {
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
    gameData.enemies.value = gameData.generateRandomEnemies();
    addAll(gameData.enemies.value);

    gameData.cards.value = gameData.generateRandomCards();
    addAll(gameData.cards.value);

    gameData.hearts.value = gameData.fullHealth();
    addAll(gameData.hearts.value);
  }

  Enemy getRandomEnemy() {
    Enemy enemy = gameData.enemies.value[Random().nextInt(3)];
    if (enemy.health <= 0) {
      return getRandomEnemy();
    } else {
      return enemy;
    }
  }

  void physicAttack() async {
    final int minDamage = playerData.meleeMinDamage.value;
    final int maxDamage = playerData.meleeMaxDamage.value;
    final int damage = minDamage + Random().nextInt(maxDamage - minDamage);
    final Enemy? enemy = target?.enemy;
    _player.meleeAttack(enemy!, damage);
  }

  void magicAttack() async {
    final int minDamage = playerData.magicMinDamage.value;
    final int maxDamage = playerData.magicMaxDamage.value;
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
      playerData.health.value += playerData.healingPower.value;
    }
    playerTurn = false;
  }

  void updateCards(row) async {
    remove(gameData.cards.value[row]);
    gameData.replaceCard(row);
    await add(gameData.cards.value[row]);
  }

  void updateHealthContainer(health) {
    removeAll(gameData.hearts.value);
    gameData.updateHealth(health);
    addAll(gameData.hearts.value);
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
    gameData.enemies.value = gameData.generateRandomEnemies();
    addAll(gameData.enemies.value);
  }

  void resetGameData() {
    gameData.enemies.value = [];
    gameData.cards.value = [];
    gameData.hearts.value = [];
  }

  void resetPlayerData() {
    playerData.isPlayerTurn.value = true;
    playerData.health.value = 12;
    playerData.coins.value = 0;
    playerData.meleeMinDamage.value = 3;
    playerData.meleeMaxDamage.value = 4;
    playerData.magicMinDamage.value = 1;
    playerData.magicMaxDamage.value = 6;
    playerData.healingPower.value = 2;
  }

  void reset() {
    gameData.enemies.value.forEach(((element) {
      if (element.health > 0) remove(element);
    }));
    removeTarget();
    removeAll(gameData.cards.value);
    removeAll(gameData.hearts.value);
    resetPlayerData();
    resetGameData();
    startGame();
  }

  void activeEyeLaser(Vector2 position) {
    add(EyeAttack()..position = Vector2(position.x, position.y + 16));
  }

  Vector2 getPlayerPosition() => _player.position;
}
