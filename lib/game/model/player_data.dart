import 'package:flutter/foundation.dart';

class PlayerData {
  final isPlayerTurn = ValueNotifier<bool>(true);

  final health = ValueNotifier<int>(12);
  final coins = ValueNotifier<int>(0);

  final meleeMinDamage = ValueNotifier<int>(2);
  final meleeMaxDamage = ValueNotifier<int>(3);

  final magicMinDamage = ValueNotifier<int>(1);
  final magicMaxDamage = ValueNotifier<int>(4);
}
