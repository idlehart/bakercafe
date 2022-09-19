import 'package:baker/components/food_sprite.dart';
import 'package:baker/main.dart';
import 'package:collection/collection.dart';
import 'package:flame/components.dart';

class SpriteTray extends PositionComponent with HasGameRef<BakerCafe> {
  @override
  bool get debugMode => false;

  FoodSprite bread = FoodSprite(spriteId: 0);
  FoodSprite coffee = FoodSprite(spriteId: 1);
  FoodSprite donut = FoodSprite(spriteId: 2);
  FoodSprite donutSprinkle = FoodSprite(spriteId: 3);
  FoodSprite egg = FoodSprite(spriteId: 4);
  FoodSprite slice = FoodSprite(spriteId: 5);
  FoodSprite soda = FoodSprite(spriteId: 6);

  SpriteTray(Vector2 position, Vector2 size)
      : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    children.register<FoodSprite>();
    _addSprites();
  }

  @override
  void update(double dt) {
    super.update(dt);
    double travelSpeed = 100;

    children.query<FoodSprite>().forEachIndexed(
          ((index, foodSprite) => {foodSprite.x += travelSpeed * dt}),
        );
  }

  void _addSprites() {
    final children = [
      bread
        ..sprite = gameRef.atlas.getSprite('Bread')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2(size.x * .13, size[1] / 2),
      coffee
        ..sprite = gameRef.atlas.getSprite('Coffee')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size.x * .13) * 2, size[1] / 2),
      donut
        ..sprite = gameRef.atlas.getSprite('Donut')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size.x * .13) * 3, size[1] / 2),
      donutSprinkle
        ..sprite = gameRef.atlas.getSprite('Sprinkle')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size.x * .13) * 4, size[1] / 2),
      egg
        ..sprite = gameRef.atlas.getSprite('Egg')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size.x * .13) * 5, size[1] / 2),
      slice
        ..sprite = gameRef.atlas.getSprite('Slice')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size.x * .13) * 6, size[1] / 2),
      soda
        ..sprite = gameRef.atlas.getSprite('Soda')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size.x * .13) * 7, size[1] / 2),
    ];
    addAll(children);
  }
}
