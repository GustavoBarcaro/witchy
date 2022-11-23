import 'package:flutter/foundation.dart';

class PlayerData {
  final health = ValueNotifier<int>(12);
  final coins = ValueNotifier<int>(0);

  int meleeMinDamage = 3;
  int meleeMaxDamage = 4;

  int magicMinDamage = 1;
  int magicMaxDamage = 6;

  int healingPower = 2;
}
