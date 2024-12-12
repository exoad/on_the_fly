import 'package:flutter/rendering.dart';
import 'package:on_the_fly/shared/app.dart';

class ColorHelper {
  ColorHelper._();

  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color randomColor(
      {double saturation = 0.6, double brightness = 0.75}) {
    double hue = random.nextDouble();
    return HSVColor.fromAHSV(1.0, hue * 360.0, saturation, brightness)
        .toColor();
  }

  static List<Color> randomColors(int min, int max) {
    List<Color> colors = <Color>[];
    for (int i = 0; i < random.nextInt(max - min) + min; i++) {
      colors.add(randomColor());
    }
    return colors;
  }
}
