import 'dart:math';

import 'package:example_forge2d/forge2d/balls.dart';
import 'package:flame/gestures.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:forge2d/forge2d.dart';

import 'package:example_forge2d/forge2d/boundaries.dart';

class CircleShuffler extends BodyComponent {
  final Vector2 _center;

  CircleShuffler(this._center) {
    debugMode = true;
  }
  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = _center + Vector2(0.0, -25.0);
    const numPieces = 12;
    const radius = 6.0;
    final body = world.createBody(bodyDef);

    for (var i = 0; i < numPieces; i++) {
      final xPos = radius * cos(2 * pi * (i / numPieces));
      final yPos = radius * sin(2 * pi * (i / numPieces));

      final shape = CircleShape()
        ..radius = 0.5
        ..position.setValues(xPos, yPos);

      final fixtureDef = FixtureDef(shape)
        ..density = 50.0
        ..friction = 0
        ..restitution = 0;

      body.createFixture(fixtureDef);
    }
    // Create an empty ground body.
    final groundBody = world.createBody(BodyDef());

    final revoluteJointDef = RevoluteJointDef()
      ..initialize(body, groundBody, body.position)
      ..motorSpeed = pi * 2 / 3
      ..maxMotorTorque = 1000000.0
      ..enableMotor = true;

    world.createJoint(revoluteJointDef);

    return body;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}

class CornerRamp extends BodyComponent {
  final bool isMirrored;
  final Vector2 _center;

  CornerRamp(this._center, {this.isMirrored = false});

  @override
  Body createBody() {
    final shape = ChainShape();
    final mirrorFactor = isMirrored ? -1 : 1;
    final diff = 2.0 * mirrorFactor;
    final vertices = [
      Vector2(diff, 0),
      Vector2(diff + 20.0 * mirrorFactor, 20.0),
      Vector2(diff + 35.0 * mirrorFactor, 30.0),
    ];
    shape.createLoop(vertices);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..position = _center
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class CircleStressSample extends Forge2DGame with TapDetector {
  CircleStressSample() : super(gravity: Vector2(0, -10.0));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    final center = screenToWorld(camera.gameRef.viewport.effectiveSize / 2);
    addContactCallback(BallWallContactCallback());
    add(CircleShuffler(center));
    add(CornerRamp(center, isMirrored: true));
    add(CornerRamp(center));
  }

  @override
  void onTapDown(TapDownInfo details) {
    super.onTapDown(details);
    final tapPosition = details.eventPosition.game;
    final random = Random();
    // List.generate(15, (i) {
    //   final randomVector = (Vector2.random() - Vector2.all(-0.5)).normalized();
    //   add(Ball(tapPosition + randomVector, radius: random.nextDouble()));
    // });
  }
}
