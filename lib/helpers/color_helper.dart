import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:on_the_fly/shared/app.dart';

class ColorHelper {
  ColorHelper._();

  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color randomColor({double saturation = 0.6, double brightness = 0.75}) {
    double hue = random.nextDouble();
    return HSVColor.fromAHSV(1.0, hue * 360.0, saturation, brightness).toColor();
  }

  static List<Color> randomColors(int min, int max) {
    List<Color> colors = <Color>[];
    for (int i = 0; i < random.nextInt(max - min) + min; i++) {
      colors.add(randomColor());
    }
    return colors;
  }
}

extension ColorExtension on Color {
  /// adapted from java.awt.Color's api
  Color brighter([double factor = 0.7]) {
    int i = (1.0 / (1.0 - factor)).toInt();
    if (red == 0 && green == 0 && blue == 0) {
      return Color.fromARGB(alpha, i, i, i);
    }
    int r = red;
    int g = green;
    int b = blue;
    if (r > 0 && r < i) {
      r = i;
    }
    if (g > 0 && g < i) {
      g = i;
    }
    if (b > 0 && b < i) {
      b = i;
    }
    return Color.fromARGB(min((r / factor).toInt(), 255), min((g / factor).toInt(), 255),
        min((b / factor).toInt(), 255), alpha);
  }

  // adapted from java.awt.Color's api
  Color darker([double factor = 0.7]) {
    return Color.fromARGB(alpha, max((red * factor).toInt(), 0),
        max((green * factor).toInt(), 0), max((blue * factor).toInt(), 0));
  }
}
