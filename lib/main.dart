import 'package:flame/flame.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:witchy/game/screens/main_menu.dart';
import 'package:witchy/game.dart';

const spriteSize = 64.0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  final game = WitchyGame();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Witchy',
    home: Scaffold(
        body: MainMenu(
      gameRef: game,
    )),
  ));
}
