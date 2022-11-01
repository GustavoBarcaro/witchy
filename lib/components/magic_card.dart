import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:witchy/main.dart';

class MagicCard extends SpriteAnimationComponent
    with HasGameRef<WitchyGame>, Tappable {
  late final SpriteAnimation _idleAnimation;

  final double _animationSpeed = .10;

  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('cards/magic_card_spritesheet.png'),
        columns: 12,
        rows: 1);

    _idleAnimation = idleSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, loop: false);
  }

  @override
  Future<void> onLoad() async {
    final double cardWidth = (gameRef.size[0] / 3.0) - 20.0;
    final double cardHeight = (gameRef.size[0] / 2.0) - 22.0;

    await _loadAnimations().then((_) => {animation = _idleAnimation});
    position = Vector2(gameRef.size[0] - (gameRef.size[0] / 3.0) + 5,
        gameRef.size[1] - (gameRef.size[0] / 2.0) + 11.0);
    size = Vector2(cardWidth, cardHeight);
  }

  @override
  bool onTapDown(info) {
    gameRef.magicAttack();
    return false;
  }
}
