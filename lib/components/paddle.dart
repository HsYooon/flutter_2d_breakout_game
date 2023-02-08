import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tutorial/forge2d_game_world.dart';
import 'package:flame/extensions.dart';

class Paddle extends BodyComponent<Forge2DGameWorld> with Draggable {
  final Size size;
  final Vector2 position;
  final BodyComponent ground;

  Paddle({
    required this.size,
    required this.position,
    required this.ground,
  });

  MouseJoint? _mouseJoint;
  Vector2 dragStartPoint = Vector2.zero();
  Vector2 dragAccumlativePosition = Vector2.zero();

  @override
  Body createBody() {
    final bodyDef = BodyDef()
        ..type = BodyType.dynamic
        ..position = position
        ..fixedRotation = true
        ..angularDamping = 1.0
        ..linearDamping = 10.0;

    final paddleBody = world.createBody(bodyDef);

    final shape = PolygonShape()
    ..setAsBox(size.width / 2.0, size.height / 2.0
        , Vector2(0, 0), 0.0);
    
    paddleBody.createFixture(FixtureDef(shape))
    ..density = 100
    ..friction = 0.0
    ..restitution = 1.0;
    return paddleBody;
  }


  @override
  bool onDragStart(DragStartInfo info) {
    if(_mouseJoint != null) {
      return true;
    }
    dragStartPoint = info.eventPosition.game;
    _setupDragControls();

    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    dragAccumlativePosition += info.delta.game;
    if((dragAccumlativePosition - dragStartPoint).length > 0.1) {
      _mouseJoint?.setTarget(dragAccumlativePosition);
      dragStartPoint = dragAccumlativePosition;
    }
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    _resetDragControls();
    return false;
  }

  @override
  bool onDragCancel() {
    _resetDragControls();
    return false;
  }

  void _setupDragControls() {
    final mouseJointDef = MouseJointDef()
        ..bodyA = ground.body
        ..bodyB = body
        ..frequencyHz = 5.0
        ..dampingRatio = 0.9
        ..collideConnected = false
        ..maxForce = 2000.0 * body.mass;

    _mouseJoint = MouseJoint(mouseJointDef);
    world.createJoint(_mouseJoint!);
  }

  void _resetDragControls() {
    dragAccumlativePosition = Vector2.zero();
    if(_mouseJoint != null) {
      world.destroyJoint(_mouseJoint!);
      _mouseJoint = null;
    }
  }

  @override
  void onMount() {
    super.onMount();

    final worldAxis = Vector2(1.0, 0.0);
    final travelExtent = (gameRef.size.x/2) - (size.width / 2.0);

    final jointDef = PrismaticJointDef()
    ..enableLimit = true
    ..lowerTranslation = -travelExtent
    ..upperTranslation = travelExtent
    ..collideConnected = true;

    jointDef.initialize(body, ground.body, body.worldCenter, worldAxis);
    final joint = PrismaticJoint(jointDef);
    world.createJoint(joint);
  }

}