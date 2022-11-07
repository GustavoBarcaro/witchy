import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:witchy/game/actors/card.dart';
import 'package:witchy/game/actors/enemy.dart';

class GameData {
  final enemies = ValueNotifier<List<Enemy>>([]);
  final cards = ValueNotifier<List<Card>>([]);

  List<Enemy> generateRandomEnemies() {
    final random = Random();
    List<Enemy> response = [];

    for (var i = 0; i < 3; i++) {
      response.add(Enemy(type: random.nextInt(3), rowNumber: i));
    }
    return response;
  }

  List<Card> generateRandomCards() {
    final random = Random();
    List<Card> response = [];

    for (var i = 0; i < 3; i++) {
      response.add(Card(type: random.nextInt(3), rowNumber: i));
    }
    return response;
  }

  void replaceCard(int row) {
    final random = Random();
    cards.value[row] = Card(type: random.nextInt(3), rowNumber: row);
  }
}
