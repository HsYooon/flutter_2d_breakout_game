import 'package:flame/game.dart';
import '../forge2d_game_world.dart';
import 'package:flutter/material.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  _MainGamePageState createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {
  final rwGreen = const Color.fromARGB(255, 21, 132, 67);
  final forge2dGameWorld = Forge2DGameWorld();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rwGreen,
      body: Container(
        color: Colors.blueGrey.withOpacity(0.3),
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: GameWidget(
          game: forge2dGameWorld,
        )
      ),
    );
  }
}
