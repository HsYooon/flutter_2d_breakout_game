import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tutorial/components/arena.dart';
import 'package:flame_tutorial/components/dead_zone.dart';
import 'package:flame_tutorial/components/paddle.dart';
import 'components/brick_wall.dart';
import 'components/ball.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

// Define Games state
enum GameState {
  initializing,
  ready,
  running,
  paused,
  won,
  lost,
}

class Forge2DGameWorld extends Forge2DGame with HasDraggables {
  Forge2DGameWorld() : super(gravity: Vector2.zero(), zoom : 20);

  GameState gameState = GameState.initializing;
  late final Ball _ball;

  @override
  Future<void> onLoad() async{
    await _initializeGame();
    
    _ball.body.applyLinearImpulse((Vector2(-10,-10)));
  }

  Future<void> _initializeGame() async {
    // Change Game state
    gameState = GameState.ready;

    final arena = Arena();
    await add(arena);

    final brickWallPosition = Vector2(0.0, size.y * 0.075);
    final brickWall = BrickWall(
      position: brickWallPosition,
      rows: 8,
      columns: 6,
    );
    await add(brickWall);

    const paddleSize = Size(4.0, 0.8);
    final paddlePosition = Vector2(size.x / 2.0, size.y * 0.85);

    final paddle = Paddle(size: paddleSize, position: paddlePosition,ground: arena);
    await add(paddle);

    _ball = Ball(
      radius: 0.5,
      positoin: size/2,
    );
    await add(_ball);

    final deadZoneSize = Size(size.x, size.y * 0.1);
    final deadZonePosition = Vector2(
      size.x / 2.0,
      size.y - (size.y * 0.1) / 2.0,
    );

    final deadZone = DeadZone(size: deadZoneSize, position: deadZonePosition);
    await add(deadZone);

  }
}