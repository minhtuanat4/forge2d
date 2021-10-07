import 'package:flame/extensions.dart';

// This class stores all the data
// necessary for creation of an enemy.
class GoalData {
  final Image image;
  final int nFrames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final int point;
  final bool isEnemy;

  const GoalData({
    required this.image,
    required this.nFrames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.point,
    required this.isEnemy,
  });
}
