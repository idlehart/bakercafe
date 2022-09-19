import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class TextBox extends TextBoxComponent {

  TextBox({
    super.text,
    super.align,
    super.size,
    super.anchor,
    super.position,
    double? timePerChar,
    EdgeInsets? margins,
    Paint? paint,
    double? maxWidth,
    TextPaint? textPaint,
  }) : super(
          textRenderer: textPaint ?? _box,
          boxConfig: TextBoxConfig(
            maxWidth: maxWidth ?? 100,
            timePerChar: timePerChar ?? 0.05,
            growingBox: true,
            margins: margins ?? const EdgeInsets.all(10),
          ),
        );

}

final _box = _regular.copyWith(
  (style) => style.copyWith(
    fontFamily: 'monogram',
    letterSpacing: 1.5
  ),
);
final _regularTextStyle = TextStyle(
  fontSize: 26,
  color: BasicPalette.cyan.color,
);
final _regular = TextPaint(style: _regularTextStyle);
