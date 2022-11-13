// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flame/components.dart';
import 'package:witchy/game.dart';

class Hud extends Component with HasGameRef<WitchyGame> {
  Hud({super.children, super.priority, positionType = PositionType.viewport});

  @override
  Future<void> onLoad() async {
    final healthTextComponent = TextComponent(
      text: 'Health: 12',
      position: Vector2.all(10),
    );
    add(healthTextComponent);

    final coinTextComponent = TextComponent(
        text: '0',
        position: Vector2(gameRef.size.x - 10, 10),
        anchor: Anchor.topRight);
    //   text: '0',
    //   textRenderer: TextPaint(
    //       style: GoogleFonts.getFont(
    //     'Press Start 2P',
    //     fontSize: 32,
    //     color: Colors.black,
    //   )),
    //   position: Vector2(gameRef.size.x - 32, 32),
    //   anchor: Anchor.topRight,
    // );
    add(coinTextComponent);

    final coincollectables = SpriteComponent(
      sprite: await gameRef.loadSprite('collectables/coin.png'),
      size: Vector2(64, 64),
      position: Vector2(gameRef.size.x, 10),
      anchor: Anchor.topRight,
    );
    add(coincollectables);

    gameRef.playerData.health.addListener(() {
      healthTextComponent.text = 'Health: ${gameRef.playerData.health.value}';
    });

    gameRef.playerData.coins.addListener(() {
      coinTextComponent.text = '${gameRef.playerData.coins.value}';
    });

    return super.onLoad();
  }
}
