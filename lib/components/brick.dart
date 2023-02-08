

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tutorial/forge2d_game_world.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ball.dart';

class Brick extends BodyComponent<Forge2DGameWorld> with ContactCallbacks{
  final Size size;
  final Vector2 position;

  Brick({required this.size, required this.position});

  @override
  Body createBody() {
    final bodyDef = BodyDef()
        ..userData = this
        ..type = BodyType.static
        ..position = position
        ..angularDamping = 1.0
        ..linearDamping = 1.0;

    final brickBody = world.createBody(bodyDef);

    final shape = PolygonShape()
    ..setAsBox(size.width/2.0, size.height/2.0, Vector2(0.0,0.0), 0.0);

    brickBody.createFixture(FixtureDef(shape)
      ..density = 100.0
      ..friction = 0.0
      ..restitution = 0.1,
    );
    return brickBody;
  }
  var destroy = false;

  @override
  void beginContact(Object other, Contact contact) {
    if(other is Ball) {
      destroy = true;
    }
  }

}
