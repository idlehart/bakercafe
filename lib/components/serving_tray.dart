import 'package:baker/components/food_order.dart';
import 'package:baker/components/food_sprite.dart';
import 'package:baker/main.dart';
import 'package:collection/collection.dart';
import 'package:flame/components.dart';

class ServingTray extends PositionComponent with HasGameRef<BakerCafe> {
  @override
  bool get debugMode => false;

  bool trayAccepted = false;

  List<int> correctOrder = [];
  List<int> servedOrder = [];

  void reset() {
    correctOrder.clear();
    servedOrder.clear();
  }

  ServingTray() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    children.register<FoodSprite>();
    children.register<FoodOrder>();
  }

  @override
  void update(double dt) {
    super.update(dt);
    const travelSpeed = 200;
    final currentOrder = children.query<FoodOrder>().firstOrNull;

    children.query<FoodSprite>().forEachIndexed((index, foodSprite) {
      if (foodSprite.x <=
          size.x - (foodSprite.size.x + 10) * (index + 1) - size.x * .2) {
        foodSprite.x += travelSpeed * dt;
      }
    });
    // Do we have a food order? Do served items count as many ordered foods?
    if ((currentOrder?.content.isNotEmpty ?? false) &&
        currentOrder?.content.length == children.query<FoodSprite>().length) {
      // Fill correct order list
      if (correctOrder.length < currentOrder!.content.length) {
        for (var food in currentOrder.content) {
          correctOrder.add(food.id);
          correctOrder.sort();
        }
      }
    }
  }
}
