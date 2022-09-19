import 'package:baker/components/food.dart';
import 'package:baker/components/food_order.dart';
import 'package:baker/main.dart';
import 'package:flame/components.dart';
import 'package:collection/collection.dart';

class OrderTray extends PositionComponent with HasGameRef<BakerCafe> {
  // Timer? _countDown;
  late TimerComponent spawnTimer;
  double spawnTimerInterval = 3;
  int travelSpeed = 75;

  OrderTray() : super(anchor: Anchor.center);

  void increaseSpawnTimer() {
    spawnTimerInterval = spawnTimerInterval * 0.5;
    remove(spawnTimer);
    add(spawnTimer = TimerComponent(
        period: spawnTimerInterval, repeat: true, onTick: addOrder));
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // _countDown = Timer(spawnTimer, repeat: true, onTick: (() => addOrder()));
    children.register<FoodOrder>();
    add(spawnTimer = TimerComponent(
        period: spawnTimerInterval, repeat: true, onTick: addOrder));
  }

  @override
  void update(double dt) {
    super.update(dt);
    // _countDown.update(dt);

    if (children.length > 6 && !gameRef.gameOver) {
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
  bool get debugMode => false;

  void addOrder() {
    if (children.length <= 7) {
      FoodOrder newOrder = FoodOrder(
          orderNumber: gameRef.orderNummber++, content: Food.randomList());

      add(newOrder);
    }
  }
}
