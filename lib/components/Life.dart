// ignore: file_names
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

// ignore: camel_case_types
/*class lifes extends SpriteComponent with HasGameRef {
  late final SpriteComponent _idleAnimation;
  final double animationSpeed = .1;
  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
         await gameRef.images.load('lifes/heart.png'),
        columns: 1,
        rows: 1
        );
    
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<void> onload() async {
       position = Vector2(0,0);
    size = Vector2.all(128.0);
  }
}
SpriteComponent with HasGameRef
*/
// ignore: camel_case_types
class lifes extends FlameGame {
  late final SpriteComponent life = SpriteComponent();
  late final SpriteComponent _life = SpriteComponent();
  late final SpriteComponent _lifee = SpriteComponent();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    life
      ..sprite = await loadSprite('lifes/heart.png')
      ..size = Vector2(64, 64)
      ..x = 5;

    add(life);
    _life
      ..sprite = await loadSprite('lifes/heart.png')
      ..size = Vector2(64, 64)
      ..x = 75;
    add(_life);
    _lifee
      ..sprite = await loadSprite('lifes/heart.png')
      ..size = Vector2(64, 64)
      ..x = 145;
    add(_lifee);
  }
}
// ignore: camel_case_types
