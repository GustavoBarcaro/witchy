import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Ghost extends SpriteAnimationComponent with HasGameRef {
  late final SpriteAnimation _idleAnimation;

  final double _animationSpeed = .20;

  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
            await gameRef.images.load('enemies/red_ghost_idle_spritesheet.png'),
        columns: 4,
        rows: 1);

    _idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _idleAnimation});
    position = Vector2(gameRef.size[0] - 96.0, gameRef.size[1] / 2.0 + 64.0);
    size = Vector2.all(64.0);
  }
}
