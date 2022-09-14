import 'package:baker/components/food.dart';
import 'package:baker/components/order_tray.dart';
import 'package:baker/components/serving_tray.dart';
import 'package:baker/components/text_box.dart';
import 'package:baker/main.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class FoodOrder extends PositionComponent with Tappable, HasGameRef<BakerCafe> {
  FoodOrder({
    required this.orderNumber,
    required this.content,
  }) : super(anchor: Anchor.center, size: Vector2(100, 150));

  final int orderNumber;
  final List<Food> content;
  late final Rect backgroundRect;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    createFoodForOrder();
    backgroundRect = size.toRect();
  }

  @override
  void onMount() {
    final parent = this.parent;

    if (parent is ServingTray) {
      add(MoveToEffect(
        Vector2(parent.size.x - size.x / 2 - 50, parent.size.y / 2),
        EffectController(duration: .3),
      ));
    } else if (parent is OrderTray) {
      position = Vector2(size.x / 2, parent.size.y / 2);
    }
    super.onMount();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (gameRef.servingTray.children.isEmpty) {
      changeParent(gameRef.servingTray);
    }
    return true;
  }

  void createFoodForOrder() {
    List<TextBox> orderContent = [];

    content.asMap().forEach(
          (key, value) => orderContent.add(
            TextBox(
              value.label,
              timePerChar: 0,
              margins: 10,
            )..position = Vector2(0, (key + 1) * 25),
          ),
        );

    final children = [
      TextBox(
        '# $orderNumber',
        align: Anchor.center,
        timePerChar: 0,
        margins: 10,
      )..position = Vector2(0, 0),
      ...orderContent
    ];

    addAll(children);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(backgroundRect, Paint()..color = Colors.blueGrey);
  }
}
