import 'package:flame/game.dart';
import 'package:flame_tutorial/ui/main_game_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BreakoutApp());
}

class BreakoutApp extends StatelessWidget {
  const BreakoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breakout',
      home: MainGamePage(),
    );
  }
}

