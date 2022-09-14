import 'package:flame/components.dart';
import 'package:flame/input.dart';

class FoodSprite extends SpriteComponent with Tappable, HasGameRef {
  double travelSpeed = 150;

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.size[0] * .8 < x) {
      resetPosition();
    }
    x += travelSpeed * dt;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    return true;
  }

  void resetPosition() {
    x = 0;
  }
}
