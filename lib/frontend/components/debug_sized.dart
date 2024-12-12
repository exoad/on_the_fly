import 'package:flutter/widgets.dart';
import 'package:on_the_fly/helpers/color_helper.dart';
import "package:dotted_border/dotted_border.dart";

class DebugBorderWidget extends StatelessWidget {
  final Widget child;

  const DebugBorderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        padding: EdgeInsets.zero,
        strokeWidth: 2,
        color: ColorHelper.randomColor(),
        child: child);
  }
}
