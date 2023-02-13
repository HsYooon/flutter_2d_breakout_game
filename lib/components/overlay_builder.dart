import 'package:flame_tutorial/forge2d_game_world.dart';
import 'package:flutter/material.dart';


class OverlayBuilder {
  OverlayBuilder._();

  static Widget preGame(BuildContext context, Forge2DGameWorld game) {
    return const PreGameOverlay();
  }
}

class PreGameOverlay extends StatelessWidget {
  const PreGameOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Tap Paddle to Begin',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
