import 'package:baker/components/food_sprite.dart';
import 'package:flame/components.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';

class SpriteTray extends PositionComponent with HasGameRef {
  @override
  bool get debugMode => true;

  FoodSprite bread = FoodSprite();
  FoodSprite coffee = FoodSprite();
  FoodSprite donut = FoodSprite();
  FoodSprite donutSprinkle = FoodSprite();
  FoodSprite egg = FoodSprite();
  FoodSprite slice = FoodSprite();
  FoodSprite soda = FoodSprite();

  late FireAtlas _atlas;

  SpriteTray(Vector2 position, Vector2 size)
      : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    _atlas = await gameRef.loadFireAtlas('food-sprites.fa');
    super.onLoad();

    _addSprites();
  }

  void _addSprites() {
    final children = [
      bread
        ..sprite = _atlas.getSprite('Bread')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2(size[0] / 7, size[1] / 2),
      coffee
        ..sprite = _atlas.getSprite('Coffee')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size[0] / 7) * 2, size[1] / 2),
      donut
        ..sprite = _atlas.getSprite('Donut')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size[0] / 7) * 3, size[1] / 2),
      donutSprinkle
        ..sprite = _atlas.getSprite('Donut-sprinkle')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size[0] / 7) * 4, size[1] / 2),
      egg
        ..sprite = _atlas.getSprite('Egg')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size[0] / 7) * 5, size[1] / 2),
      slice
        ..sprite = _atlas.getSprite('Slice')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size[0] / 7) * 6, size[1] / 2),
      soda
        ..sprite = _atlas.getSprite('Soda')
        ..size = Vector2(50, 50)
        ..anchor = Anchor.center
        ..position = Vector2((size[0] / 7) * 7, size[1] / 2),
    ];
    addAll(children);
  }
}
