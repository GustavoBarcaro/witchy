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

    final coin = gameRef.size.y / 2;
    final coincollectables = SpriteComponent(
        sprite: await gameRef.loadSprite('collectables/coin.png'),
        size: Vector2(64, 64),
        position: Vector2(gameRef.size.x, 10),
        anchor: Anchor.topRight //( gameRef.size.y -10,10 ),//- coin

        );
    add(coincollectables);
    // final lifes = gameRef.size.x / 2 + 50;
    final lifeHeart1 = SpriteComponent(
      sprite: await gameRef.loadSprite('lifes/heart.png'),
      size: Vector2(64, 64),
      position: Vector2(5, 10),
      anchor: Anchor.topLeft,
    );
    add(lifeHeart1);
    // final life2 = gameRef.size.x / 2 + 50;
    final lifeHeart2 = SpriteComponent(
        sprite: await gameRef.loadSprite('lifes/heart.png'),
        size: Vector2(64, 64),
        position: Vector2(69, 10),
        anchor: Anchor.topLeft);

    add(lifeHeart2);
    // final life3 = gameRef.size.x / 2 + 50;
    final lifeHeart3 = SpriteComponent(
        sprite: await gameRef.loadSprite('lifes/heart.png'),
        size: Vector2(64, 64),
        position: Vector2(133, 10));

    add(lifeHeart3);

    gameRef.playerData.health.addListener(() {
      healthTextComponent.text = 'Health: ${gameRef.playerData.health.value}';
    });

    gameRef.playerData.coins.addListener(() {
      coinTextComponent.text = '${gameRef.playerData.coins.value}';
    });

    return super.onLoad();
  }
}
