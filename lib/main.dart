import 'package:flame/flame.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:witchy/game/screens/main_menu.dart';

const spriteSize = 64.0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Witchy',
    home: Scaffold(body: MainMenu()),
  ));
}
