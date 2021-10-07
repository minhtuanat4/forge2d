import 'package:flame/gestures.dart';

import 'package:example_forge2d/forge2d/domino_sample.dart';

class CameraSample extends DominoSample with TapDetector {
  @override
  void onTapDown(TapDownInfo details) {
    final position = details.eventPosition.game;
    final pizza = Pizza(position, pizzaImage);
    add(pizza);
    final component = pizza.positionComponent;
    camera.followComponent(component);
  }
}
