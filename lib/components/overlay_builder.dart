import 'package:flame_tutorial/forge2d_game_world.dart';
import 'package:flutter/material.dart';


class OverlayBuilder {
  OverlayBuilder._();

  static Widget preGame(BuildContext context, Forge2DGameWorld game) {
    return const PreGameOverlay();
  }

  static Widget postGame(BuildContext context, Forge2DGameWorld game) {
    assert(game.gameState == GameState.lost || game.gameState == GameState.won);

    final message = game.gameState == GameState.won ? 'Winner!' : 'Game Over';
    return PostGameOverlay(message : message, game:game);
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

class PostGameOverlay extends StatelessWidget {
  final String message;
  final Forge2DGameWorld game;


  const PostGameOverlay({
    super.key,
    required this.message,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          _resetButton(context, game),
        ],
      ),
    );
  }

  Widget _resetButton(BuildContext context, Forge2DGameWorld game) {
    return OutlinedButton.icon(onPressed: () => game.resetGame(),
        icon : const Icon(Icons.restart_alt_outlined), label: const Text("Replay"));

  }
 }

