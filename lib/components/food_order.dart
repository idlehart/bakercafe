import 'package:baker/main.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class FoodOrder extends PositionComponent with Tappable {
  FoodOrder({
    required this.orderNumber,
    required this.content,
  });

  final int orderNumber;
  final List<Food> content;

  @override
  Future<void> onLoad() async {
    createChildren();
  }

  void createChildren() {
    double gap = 10;

    final children = [
      TextComponent(
          text: '# $orderNumber',
          textRenderer: TextPaint(
            style: TextStyle(fontSize: 18, color: BasicPalette.black.color),
          ))
        ..anchor = Anchor.topLeft,
// TODO: Find a way to spread the list of products into TextComponents.
      // for (Food food in content)
    ];

    addAll(children);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    Rect rect = Offset.zero & const Size(100, 150);

    canvas.drawRect(rect, Paint()..color = Colors.white);
  }
}
