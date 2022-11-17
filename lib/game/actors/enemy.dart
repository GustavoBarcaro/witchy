import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'package:witchy/game.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<WitchyGame>, Tappable {
  Enemy({required this.type, required this.rowNumber});

  final int type;
  final int rowNumber;

  late final List<SpriteAnimation> _idleAnimations;
  late final List<SpriteAnimation> _faintAnimations;
  late final List<SpriteAnimation> _attackAnimations;

  final double _animationSpeed = .20;

  int health = 10;

  Future<void> _loadAnimations() async {
    final idleSlimeSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
            await gameRef.images.load('enemies/red_slime_idle_spritesheet.png'),
        columns: 4,
        rows: 1);

    final idleEyeSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
            await gameRef.images.load('enemies/red_eye_idle_spritesheet.png'),
        columns: 8,
        rows: 1);

    final idleGhostSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
            await gameRef.images.load('enemies/red_ghost_idle_spritesheet.png'),
        columns: 4,
        rows: 1);

    final faintSlimeSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images
            .load('enemies/red_slime_faint_spritesheet.png'),
        columns: 4,
        rows: 1);

    final faintEyeSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
            await gameRef.images.load('enemies/red_eye_faint_spritesheet.png'),
        columns: 4,
        rows: 1);

    final faintGhostSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images
            .load('enemies/red_ghost_faint_spritesheet.png'),
        columns: 4,
        rows: 1);

    final attackSlimeSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images
            .load('enemies/red_slime_attack_spritesheet.png'),
        columns: 8,
        rows: 1);

    final attackGhostSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images
            .load('enemies/red_ghost_attack_spritesheet.png'),
        columns: 8,
        rows: 1);

    _idleAnimations = [
      idleSlimeSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed),
      idleEyeSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed),
      idleGhostSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed),
    ];

    _faintAnimations = [
      faintSlimeSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed, loop: false),
      faintEyeSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed, loop: false),
      faintGhostSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed, loop: false),
    ];

    _attackAnimations = [
      attackSlimeSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed / 2, loop: false),
      idleEyeSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed / 2, loop: false),
      attackGhostSpriteSheet.createAnimation(
          row: 0, stepTime: _animationSpeed / 2, loop: false),
    ];
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _idleAnimations[type]});
    switch (rowNumber) {
      case 0:
        position =
            Vector2(gameRef.size[0] - 96.0, gameRef.size[1] / 2.0 - 192.0);
        break;
      case 1:
        position =
            Vector2(gameRef.size[0] - 96.0, gameRef.size[1] / 2.0 - 64.0);
        break;
      case 2:
        position =
            Vector2(gameRef.size[0] - 96.0, gameRef.size[1] / 2.0 + 64.0);
        break;
      default:
        position = Vector2.all(0);
        break;
    }
    // position = Vector2(0, 0);
    size = Vector2.all(64.0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (health < 0) health = 0;

    if (health == 0) {
      removeOnFinish = true;
      animation = _faintAnimations[type];
    }
  }

  @override
  bool onTapDown(info) {
    gameRef.changeTarget(this);
    return false;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(size.x - 64, size.y + 10, health.toDouble() * 6.4, 10),
        Paint()..color = Colors.lightBlueAccent);
    super.render(canvas);
  }

  @override
  void onRemove() {
    gameRef.playerData.coins.value += 1;
    super.onRemove();
  }

  void playAttackAnimation() {
    _attackAnimations[type].reset();
    animation = _attackAnimations[type];
  }

  void attackPlayer() async {
    playAttackAnimation();
    if (type == 1) {
      gameRef.activeEyeLaser(position);
    }
    await Future.delayed(const Duration(milliseconds: 800), () {
      gameRef.playerData.health.value -= 1;
      gameRef.playerTurn = true;
      gameRef.enemyTurn = false;
      animation = _idleAnimations[type];
    });
  }
}
