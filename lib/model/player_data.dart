import 'package:flutter/foundation.dart';

class PlayerData {
  final health = ValueNotifier<int>(12);
  final coins = ValueNotifier(0);
}
