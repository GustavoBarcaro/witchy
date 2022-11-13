import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('screen/scenario.png');
    position = Vector2.all(0.0);
    size = Vector2(gameRef.size[0], gameRef.size[1] - (gameRef.size[0] / 2.0));
  }
}
