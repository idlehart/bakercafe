import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class TextBox extends TextBoxComponent {
  TextBox(
    String text, {
    super.align,
    super.size,
    double? timePerChar,
    double? margins,
  }) : super(
          text: text,
          textRenderer: _box,
          boxConfig: TextBoxConfig(
            maxWidth: 100,
            timePerChar: timePerChar ?? 0.05,
            growingBox: true,
            margins: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          ),
        );

  @override
  void render(Canvas c) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = Colors.transparent);
    super.render(c);
  }
}

final _box = _regular.copyWith(
  (style) => style.copyWith(
    color: const Color.fromARGB(255, 20, 58, 75),
    fontFamily: 'monospace',
    letterSpacing: 1.5,
  ),
);
final _regularTextStyle = TextStyle(
  fontSize: 18,
  color: BasicPalette.black.color,
);
final _regular = TextPaint(style: _regularTextStyle);