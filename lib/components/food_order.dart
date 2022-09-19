import 'package:baker/components/food.dart';
import 'package:baker/components/order_tray.dart';
import 'package:baker/components/serving_tray.dart';
import 'package:baker/components/text_box.dart';
import 'package:baker/main.dart';
import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class FoodOrder extends SpriteComponent with Tappable, HasGameRef<BakerCafe> {
  FoodOrder({
    required this.orderNumber,
    required this.content,
  }) : super(anchor: Anchor.center, size: Vector2(100, 150));

  final int orderNumber;
  final List<Food> content;
  bool scaling = false;
  late ScaleEffect scaleOnCorrectOrder;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    createFoodForOrder();
    sprite = gameRef.paperAtlas.getSprite('menupaper');
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
    final parent = this.parent;
    if (gameRef.servingTray.firstChild<FoodOrder>() == null) {
      changeParent(gameRef.servingTray);
    }
    if (parent is ServingTray) {
      if (parent.servedOrder.isNotEmpty &&
          const ListEquality()
              .equals(parent.servedOrder, parent.correctOrder)) {
        parent.reset();
        parent.removeAll(parent.children);
        gameRef.score++;
        if (gameRef.score % 3 == 0) {
          gameRef.orderTray.increaseSpawnTimer();
          print ('NEW LEVEL');
        }
      }
    }
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final parent = this.parent;

    if (parent is ServingTray) {
      if (!const ListEquality()
              .equals(parent.servedOrder, parent.correctOrder) &&
          scaling) {
        scaling = !scaling;
        remove(scaleOnCorrectOrder);
        add(ScaleEffect.to(Vector2.all(1), EffectController(duration: 0.1)));
      }

      if (parent.servedOrder.isNotEmpty &&
          const ListEquality()
              .equals(parent.servedOrder, parent.correctOrder)) {
        if (!scaling) {
          add(scaleOnCorrectOrder = ScaleEffect.to(
            Vector2.all(1.2),
            EffectController(
              reverseDuration: 0.1,
              duration: 0.3,
              curve: Curves.easeInQuad,
              infinite: true,
              alternate: true,
            ),
          ));

          scaling = true;
        }
      }
    }
  }

  void createFoodForOrder() {
    List<TextBox> orderContent = [];

    content.asMap().forEach((key, value) => orderContent.add(
          TextBox(
            text: value.label,
            margins: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            textPaint: TextPaint(
                style: const TextStyle(color: Color.fromARGB(255, 12, 24, 30))),
            position: Vector2(size.x / 2, 10 + (key + 1) * 25),
            anchor: Anchor.topCenter,
          ),
        ));

    final children = [
      TextBox(
          text: '# $orderNumber',
          align: Anchor.center,
          timePerChar: 0,
          margins: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
          position: Vector2(size.x / 2, 10),
          anchor: Anchor.topCenter,
          textPaint: TextPaint(
              style: const TextStyle(color: Color.fromARGB(255, 22, 35, 42)))),
      ...orderContent
    ];

    addAll(children);
  }
}
