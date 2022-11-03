import 'package:flame/components.dart';

class CardsDisplay extends SpriteComponent with HasGameRef {
  CardsDisplay({super.priority});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('screen/cards_display.png');
    position = Vector2(0.0, gameRef.size[1] - (gameRef.size[0] / 2.0));
    size = Vector2(gameRef.size[0], gameRef.size[0] / 2.0);
  }
}
