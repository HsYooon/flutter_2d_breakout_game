
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tutorial/forge2d_game_world.dart';
import 'package:flutter/material.dart';

import 'ball.dart';

class DeadZone extends BodyComponent<Forge2DGameWorld> with ContactCallbacks {
  final Size size;
  final Vector2 position;

  DeadZone({
    required this.size,
    required this.position
});
  @override
  Body createBody() {
    final bodyDef = BodyDef()
        ..type = BodyType.static
        ..userData = this
        ..position = position;

    final zoneBody = world.createBody(bodyDef);

    final shape = PolygonShape()
    ..setAsBox(size.width, size.height, Vector2.zero(), 0.0);

    zoneBody.createFixture(FixtureDef(shape)..isSensor = true);
    return zoneBody;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      gameRef.gameState = GameState.lost;
    }
  }
}