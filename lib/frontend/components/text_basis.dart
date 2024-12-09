import 'package:on_the_fly/shared/theme.dart';
import 'package:flutter/material.dart';

class StylizedText extends StatelessWidget {
  final String text;
  final TextStyle _style;

  StylizedText(this.text, {super.key, TextStyle? style})
      : _style = style == null
            ? const TextStyle(fontFamily: kStylizedFontFamily)
            : style.fontFamily == null ||
                    style.fontFamily != kStylizedFontFamily
                ? style.copyWith(fontFamily: kStylizedFontFamily)
                : style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _style);
  }
}

extension EasyText on String {
  Widget get text => Text(this);
}
