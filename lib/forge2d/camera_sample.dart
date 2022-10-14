import 'package:example_forge2d/forge2d/domino_sample.dart';
import 'package:flame/gestures.dart';

class CameraSample extends DominoSample with TapDetector {
  @override
  void onTapDown(TapDownInfo info) {
    final position = info.eventPosition.game;
    final pizza = Pizza(position, pizzaImage);
    add(pizza);
    final component = pizza.positionComponent;
    camera.followComponent(component);
    super.onTapDown(info);
  }
  // @override
  // void onTapDown(TapDownInfo details) {
  //   final position = details.eventPosition.game;
  //   final pizza = Pizza(position, pizzaImage);
  //   add(pizza);
  //   final component = pizza.positionComponent;
  //   camera.followComponent(component);
  // }
}
