import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class LightningAttack extends SpriteAnimationComponent with HasGameRef {
  late final SpriteAnimation _idleAnimation;

  final double _animationSpeed = .05;

  LightningAttack({super.position});

  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('character/lightning_spritesheet.png'),
        columns: 12,
        rows: 1);

    _idleAnimation = idleSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, loop: false);
  }

  @override
  Future<void> onLoad() async {
    removeOnFinish = true;
    await _loadAnimations().then((_) => {animation = _idleAnimation});
    size = Vector2(64, 128);
  }
}
