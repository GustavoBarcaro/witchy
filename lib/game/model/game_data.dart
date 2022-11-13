import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:witchy/game/actors/card.dart';
import 'package:witchy/game/actors/enemy.dart';
import 'package:witchy/game/components/heart_container.dart';

class GameData {
  final enemies = ValueNotifier<List<Enemy>>([]);
  final cards = ValueNotifier<List<Card>>([]);
  final hearts = ValueNotifier<List<HeartContainer>>([]);

  List<HeartContainer> fullHealth() {
    List<HeartContainer> response = [];

    for (var i = 0; i < 3; i++) {
      response.add(HeartContainer(type: 0, rowNumber: i));
    }
    return response;
  }

  List<Enemy> generateRandomEnemies() {
    List<Enemy> response = [];

    for (var i = 0; i < 3; i++) {
      response.add(Enemy(type: Random().nextInt(3), rowNumber: i));
    }
    return response;
  }

  List<Card> generateRandomCards() {
    List<Card> response = [];

    for (var i = 0; i < 3; i++) {
      response.add(Card(type: generateCard(), rowNumber: i));
    }
    return response;
  }

  void replaceCard(int row) {
    cards.value[row] = Card(type: generateCard(), rowNumber: row);
  }

  int generateCard() {
    final random = Random();
    int result = random.nextInt(1000);
    if (result <= 450) {
      return 0;
    } else if (result <= 800) {
      return 1;
    } else {
      return 2;
    }
  }

  void updateHealth(int health) {
    switch (health) {
      case 0:
        hearts.value[0] = HeartContainer(type: 4, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 4, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 1:
        hearts.value[0] = HeartContainer(type: 3, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 4, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 2:
        hearts.value[0] = HeartContainer(type: 2, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 4, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 3:
        hearts.value[0] = HeartContainer(type: 1, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 4, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 4:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 4, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 5:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 3, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 6:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 2, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 7:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 1, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 8:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 0, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 4, rowNumber: 2);
        break;
      case 9:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 0, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 3, rowNumber: 2);
        break;
      case 10:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 0, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 2, rowNumber: 2);
        break;
      case 11:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 0, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 1, rowNumber: 2);
        break;
      case 12:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 0, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 0, rowNumber: 2);
        break;
      default:
        hearts.value[0] = HeartContainer(type: 0, rowNumber: 0);
        hearts.value[1] = HeartContainer(type: 0, rowNumber: 1);
        hearts.value[2] = HeartContainer(type: 0, rowNumber: 2);
        break;
    }
  }
}
