import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import 'package:flutter/material.dart';

class UpgradeDisplay extends PositionComponent with HasGameRef {
  UpgradeDisplay({super.priority});

  @override
  Future<void>? onLoad() {
    position = Vector2(0.0, gameRef.size[1] - (gameRef.size[0] / 2.0));
    size = Vector2(gameRef.size[0], gameRef.size[0] / 2.0);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(),
        Paint()..color = const Color.fromARGB(255, 140, 170, 222));
  }
}
