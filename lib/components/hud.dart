import 'package:flame/components.dart';
import 'package:witchy/main.dart';

class Hud extends Component with HasGameRef<WitchyGame> {
  Hud({super.children, super.priority, positionType = PositionType.viewport});

  @override
  Future<void>? onLoad() async {
    final healthTextComponent = TextComponent(
      text: 'Health: 12',
      position: Vector2.all(10),
    );
    add(healthTextComponent);

    final coinTextComponent = TextComponent(
        text: '0',
        position: Vector2(gameRef.size.x - 10, 10),
        anchor: Anchor.topRight);
    add(coinTextComponent);

    // final cardsHeight = gameRef.size.x / 2;

    // final cardsDisplayComponent = SpriteComponent(
    //     sprite: await gameRef.loadSprite('screen/cards_display.png'),
    //     size: Vector2(gameRef.size.x, cardsHeight),
    //     position: Vector2(0, gameRef.size.y - cardsHeight));
    // add(cardsDisplayComponent);

    gameRef.playerData.health.addListener(() {
      healthTextComponent.text = 'Health: ${gameRef.playerData.health.value}';
    });

    gameRef.playerData.coins.addListener(() {
      coinTextComponent.text = '${gameRef.playerData.coins.value}';
    });

    return super.onLoad();
  }
}
