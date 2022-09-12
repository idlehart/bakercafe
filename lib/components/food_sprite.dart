import 'package:flame/components.dart';
import 'package:flame/input.dart';

class FoodSprite extends SpriteComponent with Tappable, HasGameRef {
  double travelSpeed = 150;

  @override
  void update(double dt) {
    super.update(dt);
    if (x > gameRef.size[0]) {
      resetPosition();
    }
    x += travelSpeed * dt;
  }

  @override
  bool onTapDown(TapDownInfo event) {
    print('TApped');
    return true;
  }

  void resetPosition() {
    x = 0;
  }
}