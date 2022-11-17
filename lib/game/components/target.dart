import 'package:flame/components.dart';

import 'package:witchy/game/actors/enemy.dart';

class Target extends SpriteComponent with HasGameRef {
  Target({required this.enemy});

  final Enemy enemy;

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('enemies/pointer.png');
    position =
        Vector2(enemy.position.x + (enemy.size.x / 2) - 7.5, enemy.position.y);
    size = Vector2.all(15);
    return super.onLoad();
  }
}
