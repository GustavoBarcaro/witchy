// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'package:witchy/game.dart';

class Card extends SpriteAnimationComponent
    with HasGameRef<WitchyGame>, Tappable {
  Card({required this.type, required this.rowNumber});

  final int type;
  final int rowNumber;

  late final List<SpriteAnimation> _idleAnimations;

  final double _animationSpeed = .10;

  Future<void> _loadAnimations() async {
    final idleAttackSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('cards/attack_card_spritesheet.png'),
        columns: 11,
        rows: 1);

    final idleMagicSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('cards/magic_card_spritesheet.png'),
        columns: 12,
        rows: 1);

    final idleLifeSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('cards/life_card_spritesheet.png'),
        columns: 11,
        rows: 1);

    _idleAnimations = [
      idleAttackSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed, loop: false),
      idleMagicSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed, loop: false),
      idleLifeSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed, loop: false)
    ];
  }

  @override
  Future<void> onLoad() async {
    final double cardWidth = (gameRef.size[0] / 3.0) - 20.0;
    final double cardHeight = (gameRef.size[0] / 2.0) - 22.0;
    size = Vector2(cardWidth, cardHeight);

    await _loadAnimations().then((_) => {animation = _idleAnimations[type]});

    switch (rowNumber) {
      case 0:
        position =
            Vector2(15.0, gameRef.size[1] - (gameRef.size[0] / 2.0) + 11.0);
        break;
      case 1:
        position = Vector2((gameRef.size[0] / 3.0) + 10,
            gameRef.size[1] - (gameRef.size[0] / 2.0) + 11.0);
        break;
      case 2:
        position = Vector2(gameRef.size[0] - (gameRef.size[0] / 3.0) + 5,
            gameRef.size[1] - (gameRef.size[0] / 2.0) + 11.0);
        break;
      default:
        position = Vector2.all(0);
        break;
    }
  }

  @override
  bool onTapDown(info) {
    int fainted = 0;
    gameRef.gameData.enemies.value.forEach((element) {
      if (element.health <= 0) fainted++;
    });
    if (fainted == 3) return false;
    if (gameRef.playerTurn == false ||
        gameRef.enemyTurn == true ||
        gameRef.playerAttacking == true) {
      return false;
    }

    switch (type) {
      case 0:
        gameRef.physicAttack();
        break;
      case 1:
        gameRef.magicAttack();
        break;
      case 2:
        gameRef.healing();
        break;
      default:
        break;
    }
    gameRef.updateCards(rowNumber);
    return false;
  }
}
