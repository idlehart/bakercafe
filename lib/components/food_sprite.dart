import 'package:baker/components/food_order.dart';
import 'package:baker/components/serving_tray.dart';
import 'package:baker/components/sprite_tray.dart';
import 'package:baker/main.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class FoodSprite extends SpriteComponent with Tappable, HasGameRef<BakerCafe> {
  double travelSpeed = 150;

  final int spriteId;

  FoodSprite({required this.spriteId})
      : super(size: Vector2.all(50), anchor: Anchor.center);

  @override
  void onMount() {
    final parent = this.parent;
    super.onMount();
    if (parent is ServingTray) {
      position = Vector2(parent.size.x * 0.1, parent.size.y / 2);
      parent.servedOrder.add(spriteId);
      parent.servedOrder.sort();
    }
  }

  @override
  void update(double dt) {
    final parent = this.parent;
    super.update(dt);

    if (parent is SpriteTray && x > gameRef.spriteTray.size[0] - size.x / 2) {
      resetPosition();
    }
  }

  @override
  bool onTapDown(TapDownInfo info) {
    final parent = this.parent;
    if (parent is ServingTray) {
      parent.remove(this);
      parent.servedOrder.remove(spriteId);
    } else if (parent is SpriteTray) {
      if (gameRef.servingTray.firstChild<FoodOrder>() != null) {
        gameRef.servingTray
            .add(FoodSprite(spriteId: spriteId)..sprite = sprite);
      }
    }
    return true;
  }

  void resetPosition() {
    x = size.x / 2;
  }
}
