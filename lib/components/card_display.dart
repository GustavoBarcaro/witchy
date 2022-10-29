import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';

class CardsDisplay extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();  
    sprite = await gameRef.loadSprite('screen/cards_display.png');
    position = Vector2(0.0, gameRef.size[1] - (gameRef.size[0] / 2.0));
    size = Vector2(gameRef.size[0], gameRef.size[0] / 2.0);
  }

}
 
 
 
 
/*class button extends SpriteComponent{
  SpriteButton.asset(
    onPressed: () {
      print('Pressed');
    },
    label: const Text('Sprite Button', style: const TextStyle(color: const Color(0xFF5D275D))),
    sprite: _spriteButton,
    pressedSprite: _pressedSprite,
)
} */
