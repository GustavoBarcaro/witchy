import 'package:flame/components.dart';

import 'package:witchy/game.dart';

class ActionButton extends SpriteComponent
    with HasGameRef<WitchyGame>, Tappable {
  late final Sprite pressed;
  late final Sprite unpressed;

  @override
  Future<void>? onLoad() async {
    pressed = await gameRef.loadSprite('buttons/actions_button_pressed.png');
    unpressed =
        await gameRef.loadSprite('buttons/actions_button_unpressed.png');
    sprite = pressed;
    size = Vector2(gameRef.size.x / 2, 50);
    position = Vector2(0, gameRef.size.y - (gameRef.size.x / 2) - 50);
    return super.onLoad();
  }

  @override
  bool onTapDown(info) {
    // gameRef.activeActions();
    return false;
  }

  void selectThis() {
    sprite = pressed;
  }

  void unselectThis() {
    sprite = unpressed;
  }
}
