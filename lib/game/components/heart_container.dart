import 'package:flame/components.dart';

import 'package:witchy/game.dart';

class HeartContainer extends SpriteComponent with HasGameRef<WitchyGame> {
  HeartContainer({required this.type, required this.rowNumber});

  final int type;
  final int rowNumber;

  late final List<Sprite> _heartImages;

  Future<void> _loadSprites() async {
    _heartImages = [
      await gameRef.loadSprite('lifes/heart.png'),
      await gameRef.loadSprite('lifes/three_quarter_heart.png'),
      await gameRef.loadSprite('lifes/half_heart.png'),
      await gameRef.loadSprite('lifes/quarter_heart.png'),
      await gameRef.loadSprite('lifes/empty_heart.png'),
    ];
  }

  @override
  Future<void>? onLoad() async {
    await _loadSprites().then((_) => {sprite = _heartImages[type]});
    switch (rowNumber) {
      case 0:
        position = Vector2(10, 10);
        break;
      case 1:
        position = Vector2(74, 10);
        break;
      case 2:
        position = Vector2(138, 10);
        break;
      default:
        position = Vector2.all(0);
        break;
    }

    size = Vector2.all(64.0);

    return super.onLoad();
  }
}
