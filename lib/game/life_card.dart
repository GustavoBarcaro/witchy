import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class LifeCard extends SpriteAnimationComponent with HasGameRef {
  late final SpriteAnimation _idleAnimation;

  final double _animationSpeed = .10;

  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('cards/life_card_spritesheet.png'),
        columns: 11,
        rows: 1);

    _idleAnimation = idleSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, loop: false);
  }

  @override
  Future<void> onLoad() async {
    final double cardWidth = (gameRef.size[0] / 3.0) - 20.0;
    final double cardHeight = (gameRef.size[0] / 2.0) - 22.0;

    await _loadAnimations().then((_) => {animation = _idleAnimation});
    position = Vector2((gameRef.size[0] / 3.0) + 10,
        gameRef.size[1] - (gameRef.size[0] / 2.0) + 11.0);
    size = Vector2(cardWidth, cardHeight);
  }
}
