
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tutorial/forge2d_game_world.dart';
import 'package:flutter/rendering.dart';
import 'package:flame/extensions.dart';

class Ball extends BodyComponent<Forge2DGameWorld> {
  final Vector2 positoin;
  final double radius;

  Ball({required this.positoin, required this.radius});

  final _gradient = RadialGradient(
      center: Alignment.topLeft,
      colors: [
        const HSLColor.fromAHSL(1.0, 0.0, 0.0, 1.0).toColor(),
        const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.9).toColor(),
        const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.4).toColor(),
      ],
      stops: const [0.0, 0.5, 1.0],
      radius: 0.95,
  );

  @override
  void render(Canvas canvas) {
    final circle = body.fixtures.first.shape as CircleShape;
    final paint = Paint()
    ..shader = _gradient.createShader(Rect.fromCircle(center: circle.position.toOffset(),
        radius: radius))
    ..style = PaintingStyle.fill;

    canvas.drawCircle(circle.position.toOffset(), radius, paint);
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
        ..userData = this
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

  void reset() {
    body.setTransform(positoin, angle);
    body.angularVelocity = 0.0;
    body.linearVelocity = Vector2.zero();
  }
}