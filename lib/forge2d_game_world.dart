import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tutorial/components/arena.dart';
import 'package:flame_tutorial/components/dead_zone.dart';
import 'package:flame_tutorial/components/paddle.dart';
import 'components/brick_wall.dart';
import 'components/ball.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';

// Define Games state
enum GameState {
  initializing,
  ready,
  running,
  paused,
  won,
  lost,
}

class Forge2DGameWorld extends Forge2DGame with HasDraggables,HasTappables {
  Forge2DGameWorld() : super(gravity: Vector2.zero(), zoom : 20);

  GameState gameState = GameState.initializing;
  late final Ball _ball;
  late final Arena _arena;
  late final Paddle _paddle;
  late final DeadZone _deadZone;
  late final BrickWall _brickWall;

  @override
  Future<void> onLoad() async{
    await _initializeGame();
  }

  Future<void> _initializeGame() async {
    // Change Game state
    gameState = GameState.ready;
    overlays.add('PreGame');

    _arena = Arena();
    await add(_arena);

    final brickWallPosition = Vector2(0.0, size.y * 0.075);
    _brickWall = BrickWall(
      position: brickWallPosition,
      rows: 8,
      columns: 6,
    );
    await add(_brickWall);


    const paddleSize = Size(4.0, 0.8);
    final deadZoneSize = Size(size.x, size.y * 0.1);
    final paddlePosition = Vector2(size.x / 2.0, size.y - deadZoneSize.height - paddleSize.height/2.0);
    _paddle = Paddle(size: paddleSize, position: paddlePosition,ground: _arena);
    await add(_paddle);

    final ballPosition = Vector2(size.x / 2.0, size.y / 2.0 + 10.0);
    _ball = Ball(
      radius: 0.5,
      positoin: ballPosition,
    );
    await add(_ball);

    final deadZonePosition = Vector2(
      size.x / 2.0,
      size.y - (size.y * 0.1) / 2.0,
    );

    _deadZone = DeadZone(size: deadZoneSize, position: deadZonePosition);
    await add(_deadZone);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if(gameState == GameState.lost || gameState == GameState.won) {
      pauseEngine();
      overlays.add('PostGame');
    }
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    if(gameState == GameState.ready) {
      overlays.remove('PreGame');
      _ball.body.applyLinearImpulse(Vector2(-10.0, -10.0));
      gameState = GameState.running;
    }
    super.onTapDown(pointerId, info);
  }

  Future<void> resetGame() async {
    gameState = GameState.initializing;

    _ball.reset();
    _paddle.reset();
    await _brickWall.reset();

    gameState = GameState.ready;

    overlays.remove(overlays.activeOverlays.first);
    overlays.add('PreGame');

    resumeEngine();

  }
}