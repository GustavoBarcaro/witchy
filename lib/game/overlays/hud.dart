// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:witchy/game.dart';


class Hud extends Component with HasGameRef<WitchyGame> {
  Hud({super.children, super.priority, positionType = PositionType.viewport});

  // ignore: prefer_typing_uninitialized_variables
  var imagesthree_quarter_heart;
  // ignore: prefer_typing_uninitialized_variables
  var imagesquarter_heart;
  // ignore: prefer_typing_uninitialized_variables
  var imageshalf_heart;
  // ignore: prefer_typing_uninitialized_variables
  var imagesEmpty;
  // ignore: prefer_typing_uninitialized_variables
  // var type;
  // ignore: prefer_typing_uninitialized_variables
  var imagesSprite;
  // ignore: prefer_typing_uninitialized_variables
  var rowNumber;

  int heart = 12;

  @override
  Future<void>? onLoad() async {
    final healthTextComponent = TextComponent(
      text: 'Health: 12',
      position: Vector2.all(10),
    );
    add(healthTextComponent);

    final coinTextComponent = TextComponent(
      // text: '0',

      // position: Vector2(gameRef.size.y -15, 10),
      // anchor: Anchor.topRight);
      text: '0',
      textRenderer: TextPaint(
          style: GoogleFonts.getFont(
        'Press Start 2P',
        fontSize: 32,
        color: Colors.black,
      )),
      position: Vector2(gameRef.size.x - 52, 43),
      anchor: Anchor.topRight,
    );
    add(coinTextComponent);

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

    // ignore: unused_local_variable
    late final List<Sprite> imagesLifes;
    imagesLifes = [
      imagesthree_quarter_heart =
          await gameRef.loadSprite('lifes/three_quarter_heart.png'),
      imagesquarter_heart = await gameRef.loadSprite('lifes/quarter_heart.png'),
      imageshalf_heart = await gameRef.loadSprite('lifes/half_heart.png'),
      imagesEmpty = await gameRef.loadSprite('lifes/empty_heart.png'),
    ];

    gameRef.playerData.health.addListener(() async {
      healthTextComponent.text = 'Health: ${gameRef.playerData.health.value}';
      switch (gameRef.playerData.health.value) {
        case 0:
          lifeHeart1.sprite = imagesLifes[0];
          lifeHeart2.sprite = imagesLifes[0];
          lifeHeart3.sprite = imagesLifes[0];
          break;
        case 1:
          lifeHeart1.sprite = imagesLifes[1];
          lifeHeart2.sprite = imagesLifes[1];
          lifeHeart3.sprite = imagesLifes[1];
          break;
        case 2:
          lifeHeart1.sprite = imagesLifes[2];
          lifeHeart2.sprite = imagesLifes[2];
          lifeHeart3.sprite = imagesLifes[2];
          break;
        case 3:
          lifeHeart1.sprite = imagesLifes[3];
          lifeHeart2.sprite = imagesLifes[3];
          lifeHeart3.sprite = imagesLifes[3];

          break;
        default:
      }
    });
    gameRef.playerData.coins.addListener(() {
      coinTextComponent.text = '${gameRef.playerData.coins.value}';
    });

    return super.onLoad();
  }
}





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
    
    // imageslifes = [
    //   lifeHeart1.add(lifeHeart1),
    //   lifeHeart2.add(lifeHeart2),
    //   lifeHeart3.add(lifeHeart3)
    // ];
    // Sprite(

    //   srcSize:
    //   srcPosition:lifes/three_quarter_heart.png
    // );
