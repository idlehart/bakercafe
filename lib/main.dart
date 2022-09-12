import 'package:baker/components/food_order.dart';
import 'package:baker/components/food_sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final game = BakerGame();
  runApp(GameWidget(game: game));
}

class BakerGame extends FlameGame with HasTappables {
  late FireAtlas _atlas;

  FoodSprite bread = FoodSprite();
  FoodSprite coffee = FoodSprite();
  FoodSprite donut = FoodSprite();
  FoodSprite donutSprinkle = FoodSprite();
  FoodSprite egg = FoodSprite();
  FoodSprite slice = FoodSprite();
  FoodSprite soda = FoodSprite();

  FoodOrder foodOrder = FoodOrder(orderNumber: 1, content: [
    Food(name: 'Egg'),
    Food(name: 'Bread'),
  ]);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _atlas = await loadFireAtlas('food-sprites.fa');

    add(foodOrder..anchor = Anchor.topCenter..x = 50);
    _addSprites();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (foodOrder.x < size[0] - 150) {
      foodOrder.x += 2;
    }
  }

  void _addSprites() {
    double gap = 60;
    double startPosition = -50;
    bread
      ..sprite = _atlas.getSprite('Bread')
      ..y = size[1] * .9
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topCenter
      ..x = 0;
    coffee
      ..sprite = _atlas.getSprite('Coffee')
      ..y = size[1] * .9
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topCenter
      ..x = startPosition - gap;
    donut
      ..sprite = _atlas.getSprite('Donut')
      ..y = size[1] * .9
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topCenter
      ..x = 2 * (startPosition - gap);
    donutSprinkle
      ..sprite = _atlas.getSprite('Donut-sprinkle')
      ..y = size[1] * .9
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topCenter
      ..x = 3 * (startPosition - gap);
    egg
      ..sprite = _atlas.getSprite('Egg')
      ..y = size[1] * .9
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topCenter
      ..x = 4 * (startPosition - gap);
    slice
      ..sprite = _atlas.getSprite('Slice')
      ..y = size[1] * .9
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topCenter
      ..x = 5 * (startPosition - gap);
    soda
      ..sprite = _atlas.getSprite('Soda')
      ..y = size[1] * .9
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topCenter
      ..x = 6 * (startPosition - gap);
    add(bread);
    add(coffee);
    add(donut);
    add(donutSprinkle);
    add(egg);
    add(slice);
    add(soda);
  }
}

class Food {
  Food({required this.name});
  final String name;
}
