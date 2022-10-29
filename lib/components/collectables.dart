// ignore_for_file: unused_local_variable, camel_case_types

// import 'package:flame/components.dart';
// import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class colllectables extends SpriteAnimationComponent with HasGameRef {
  late final SpriteAnimation _idleAnimation;
  final double _animationSpeed = .1;
  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('collectables/coin.png'),
        rows: 1,
        columns: 1);
    _idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _idleAnimation});
    position = Vector2(gameRef.size[0] - 68, gameRef.size[1] / 1.96 - 325.0);
    size = Vector2(64, 64);
  }
}
