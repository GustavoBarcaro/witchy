import 'package:flutter/material.dart';

import 'package:flame/components.dart';

import 'package:witchy/game.dart';

class CoinLabel extends TextComponent with HasGameRef<WitchyGame> {
  @override
  Future<void>? onLoad() {
    text = '0';
    textRenderer = TextPaint(
        style: const TextStyle(
      fontFamily: 'Press Start 2P',
      fontSize: 32,
      color: Colors.black,
    ));
    size = Vector2.all(32);
    position = Vector2(gameRef.size.x - 65, 20);
    anchor = Anchor.topRight;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    text = gameRef.playerData.coins.value.toString();
    super.update(dt);
  }
}

class CoinIcon extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('collectables/coin.png');
    position = Vector2(gameRef.size.x - 69, 5);
    size = Vector2.all(64);
    return super.onLoad();
  }
}
