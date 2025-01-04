import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:on_the_fly/shared/app.dart';

class ColorHelper {
  ColorHelper._();

  static Color withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
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

// ****************************************************************************
// THE FUCKING CHANGE FROM PROPER NAMES FOR THE COMPONENTS OF A COLOR TO
// INDIVIDUAL FUCKING LETTERS IS FUCKING STUPID WTF MAINTAINERS ???
//
// https://github.com/flutter/flutter/commit/9f66178386f34b0722d3a88717b4d6fddc247ba2#diff-005152dcaaa555ef138ebdd1580cea316c59e82d12563cdb4c8b5bd16c7e6b6dR314
// SO FUCKING STUPID BRO
// 3.27.1 PLS FUCKING REVERT THIS SHIT
//
// ALSO WHY TF IS THE INDIVIDUAL ATTRIBUTES NOW OUT OF 1.0 ?? WTF IS RELAND
// UPADTE BRUH, IDC ABOUT MOTHERFUCKING SUPPORTING JUST P3 DISPLAY CODECS ???
// https://github.com/flutter/flutter/issues/127855
// WHEN DID WE FUCKING ASK FOR THIS SHIT ????
//
// I DONT WANNA REIMPLEMENT MY CODE SUCH THAT I HAVE TO DO A FUCK TON OF (x times
// 255). INSANE MENACING CHANGE MAINTAINERS !!!
//
// CHANGING THE CORE FUNDAMENTALS IS SO FUCKING STUPID (oH baCkwArdS comPAtiBle)
//
// suck my dick
// i dont care about precision loss, it has been prefectly fine for every other
// framework that has used a normal color definition with 8bit colors
// ****************************************************************************

extension ColorExtension on Color {
  /// adapted from java.awt.Color's api
  // this shit does not work, see the above comment
  Color brighter([double factor = 0.7]) {
    int i = (1.0 / (1.0 - factor)).round();
    if (r == 0 && g == 0 && b == 0) {
      return Color.fromARGB((a * 255).round(), i, i, i);
    }
    int r_ = (r * 255).round();
    int b_ = (b * 255).round();
    int g_ = (g * 255).round();
    if (r_ > 0 && r_ < i) {
      r_ = i;
    }
    if (g_ > 0 && g_ < i) {
      g_ = i;
    }
    if (b_ > 0 && b_ < i) {
      b_ = i;
    }
    return Color.fromARGB(min((r_ / factor).toInt(), 255),
        min((g_ / factor).toInt(), 255), min((b_ / factor).toInt(), 255), a.toInt());
  }

  // adapted from java.awt.Color's api
  Color darker([double factor = 0.7]) {
    return Color.fromARGB(
        (a * 255).round(),
        max(((r * 255).round() * factor).round(), 0),
        max(((g * 255).round() * factor).round(), 0),
        max(((b * 255).round() * factor).round(), 0));
  }

  // from: https://stackoverflow.com/a/50081214 THANK YOU !!!!

  static Color fromHex(String hexString) {
    StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${((a * 255) as int).toRadixString(16).padLeft(2, '0')}'
      '${((r * 255) as int).toRadixString(16).padLeft(2, '0')}'
      '${((g * 255) as int).toRadixString(16).padLeft(2, '0')}'
      '${((b * 255) as int).toRadixString(16).padLeft(2, '0')}';
}
