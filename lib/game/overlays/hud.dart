// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:witchy/game.dart';

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

    // final actionsButtonComponent = SpriteButtonComponent(
    //     button: await gameRef.loadSprite('buttons/actions_button_pressed.png'),
    //     size: Vector2(gameRef.size.x / 2, 50),
    //     position: Vector2(0, gameRef.size.y - (gameRef.size.x / 2) - 50),
    //     onPressed: () async {});
    // add(actionsButtonComponent);

    // final upgradesButtonComponent = SpriteButtonComponent(
    //     button:
    //         await gameRef.loadSprite('buttons/upgrades_button_unpressed.png'),
    //     size: Vector2(gameRef.size.x / 2, 50),
    //     position: Vector2(
    //         gameRef.size.x / 2, gameRef.size.y - (gameRef.size.x / 2) - 50),
    //     onPressed: () {});
    // add(upgradesButtonComponent);

    // final cardsHeight = gameRef.size.x / 2;

    // final cardsDisplayComponent = SpriteComponent(
    //     sprite: await gameRef.loadSprite('screen/cards_display.png'),
    //     size: Vector2(gameRef.size.x, cardsHeight),
    //     position: Vector2(0, gameRef.size.y - cardsHeight));
    // add(cardsDisplayComponent);

    final coincollectables = SpriteComponent(
      sprite: await gameRef.loadSprite('collectables/coin.png'),
      size: Vector2(64, 64),
      position: Vector2(gameRef.size.x, 10),
      anchor: Anchor.topRight,
    );
    add(coincollectables);

    final lifeHeart1 = SpriteComponent(
      sprite: await gameRef.loadSprite('lifes/heart.png'),
      size: Vector2(64, 64),
      position: Vector2(5, 10),
      anchor: Anchor.topLeft,
    );
    add(lifeHeart1);

    final lifeHeart2 = SpriteComponent(
        sprite: await gameRef.loadSprite('lifes/heart.png'),
        size: Vector2(64, 64),
        position: Vector2(69, 10),
        anchor: Anchor.topLeft);

    add(lifeHeart2);

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
