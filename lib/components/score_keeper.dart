import 'package:baker/components/text_box.dart';
import 'package:baker/main.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreKeeper extends SpriteComponent with HasGameRef<BakerCafe> {
  Paint defaultPaint = Paint()..color = Colors.blueGrey.shade800;
  late final TextBox score;
  @override
  Future<void> onLoad() async {
    sprite = gameRef.paperAtlas.getSprite('scorepaper');
    size = Vector2(150, 50);
    add(score = TextBox(
        text: 'Score: ${gameRef.score}',
        maxWidth: 150,
        anchor: Anchor.center,
        position: size / 2,
        textPaint: TextPaint(
            style: const TextStyle(
                color: Color.fromRGBO(55, 71, 79, 1), fontSize: 18))));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    score.text = 'Score: ${gameRef.score}';
  }
}
