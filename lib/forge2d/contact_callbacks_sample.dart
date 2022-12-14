import 'dart:math' as math;

import 'package:example_forge2d/forge2d/balls.dart';
import 'package:example_forge2d/forge2d/boundaries.dart';
import 'package:flame/gestures.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:forge2d/forge2d.dart';

class ContactCallbacksSample extends Forge2DGame with TapDetector {
  ContactCallbacksSample() : super(gravity: Vector2(0, -10.0));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    addContactCallback(BallContactCallback());
    addContactCallback(BallWallContactCallback());
    addContactCallback(WhiteBallContactCallback());
  }

  @override
  void onTapDown(TapDownInfo details) {
    super.onTapDown(details);
    final position = details.eventPosition.game;
    if (math.Random().nextInt(10) < 2) {
      add(WhiteBall(position));
    } else {
      add(Ball(position));
    }
  }
}
