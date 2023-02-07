
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tutorial/forge2d_game_world.dart';

class Ball extends BodyComponent<Forge2DGameWorld> {
  final Vector2 positoin;
  final double radius;

  Ball({required this.positoin, required this.radius});

  @override
  Body createBody() {
    final bodyDef = BodyDef()
        ..type = BodyType.dynamic
        ..position = positoin;
    final ball = world.createBody(bodyDef);

    final shape = CircleShape()..radius = radius;

    final fixtureDef = FixtureDef(shape)
    ..restitution = 1.0
    ..density = 1.0;

    ball.createFixture(fixtureDef);
    return ball;
  }
}