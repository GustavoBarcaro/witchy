import 'package:flutter/foundation.dart';

class PlayerData {
  final isPlayerTurn = ValueNotifier<bool>(true);

  final health = ValueNotifier<int>(12);
  final coins = ValueNotifier<int>(0);

  final meleeMinDamage = ValueNotifier<int>(3);
  final meleeMaxDamage = ValueNotifier<int>(4);

  final magicMinDamage = ValueNotifier<int>(1);
  final magicMaxDamage = ValueNotifier<int>(6);

  final healingPower = ValueNotifier<int>(2);

  void reset() {
    isPlayerTurn.value = true;
    health.value = 12;
    coins.value = 0;
    meleeMinDamage.value = 3;
    meleeMaxDamage.value = 4;
    magicMinDamage.value = 1;
    magicMaxDamage.value = 6;
    healingPower.value = 2;
  }
}
