import 'package:baker/components/food.dart';
import 'package:baker/components/food_order.dart';
import 'package:baker/main.dart';
import 'package:flame/components.dart';
import 'package:collection/collection.dart';

class OrderTray extends PositionComponent with HasGameRef<BakerCafe> {
  late Timer _countDown;

  OrderTray() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _countDown = Timer(1, repeat: true, onTick: (() => addOrder()));

    children.register<FoodOrder>();
  }

  @override
  void update(double dt) {
    super.update(dt);
    const travelSpeed = 200;
    _countDown.update(dt);

    if (children.length > 3 && !gameRef.gameOver) {
      gameRef.gameOver = true;
      gameRef.overlays.add(pauseMenu);
      gameRef.pauseEngine();
    }

    children.query<FoodOrder>().forEachIndexed((index, order) {
      if (order.x <=
          size.x -
              (order.size.x / 2 + 10) * (index + 1) -
              (order.size.x / 2) * index) {
        order.x += travelSpeed * dt;
      }
    });
  }

  @override
  bool get debugMode => true;

  void addOrder() {
    if (children.length <= 7) {
      FoodOrder newOrder = FoodOrder(
          orderNumber: children.length + 1, content: Food.randomList());

      add(newOrder);
    }
  }
}
