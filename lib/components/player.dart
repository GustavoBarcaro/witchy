import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef {
  late final SpriteAnimation _idleAnimation;

  final double _animationSpeed = .20;

  int _health = 12;
  int get health => _health;

  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images
            .load('character/character_idle_spritesheet.png'),
        columns: 4,
        rows: 1);

    _idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _idleAnimation});
    // sprite = await gameRef.loadSprite('character/character_base.png');
    position = Vector2(16.0, gameRef.size[1] / 2.0 - 96.0);
    size = Vector2.all(128.0);
  }

  void takeDamage(int damage) {
    _health -= damage;
  }
}
