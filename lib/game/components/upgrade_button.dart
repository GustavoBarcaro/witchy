import 'package:flame/components.dart';

import 'package:witchy/game.dart';

class UpgradeButton extends SpriteComponent
    with HasGameRef<WitchyGame>, Tappable {
  late final Sprite pressed;
  late final Sprite unpressed;

  @override
  Future<void>? onLoad() async {
    pressed = await gameRef.loadSprite('buttons/upgrades_button_pressed.png');
    unpressed =
        await gameRef.loadSprite('buttons/upgrades_button_unpressed.png');
    sprite = unpressed;
    size = Vector2(gameRef.size.x / 2, 50);
    position =
        Vector2(gameRef.size.x / 2, gameRef.size.y - (gameRef.size.x / 2) - 50);
    return super.onLoad();
  }

  @override
  bool onTapDown(info) {
    // gameRef.activeUpgrades();
    return false;
  }

  void selectThis() {
    sprite = pressed;
  }

  void unselectThis() {
    sprite = unpressed;
  }
}
