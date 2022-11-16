import 'package:flame/components.dart';
import 'package:witchy/game.dart';

class EyeAttack extends SpriteComponent with HasGameRef<WitchyGame> {
  EyeAttack({super.position});

  late final Vector2 playerPositon;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('enemies/eyes_laser.png');
    size = Vector2(64, 16);
    playerPositon = gameRef.getPlayerPosition();
  }

  @override
  void update(double dt) {
    if (playerPositon.x < position.x) {
      position.x -= 5;
    }

    if (playerPositon.y + 32 != position.y) {
      if (playerPositon.y + 32 > position.y) {
        position.y += 2;
      } else {
        position.y -= 2;
      }
    }

    if (playerPositon.x >= position.x) removeFromParent();

    super.update(dt);
  }
}
