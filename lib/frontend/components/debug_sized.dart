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
        dashPattern: const <double>[4, 2],
        color: ColorHelper.randomColor(),
        child: child);
  }
}

class FlashingDebugWidget extends StatefulWidget {
  final Widget child;
  final int period;

  const FlashingDebugWidget(
      {super.key, required this.child, this.period = 300});

  @override
  State<FlashingDebugWidget> createState() => _FlashingDebugWidgetState();
}

class _FlashingDebugWidgetState extends State<FlashingDebugWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.period),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 255, 0, 220),
      end: const Color.fromRGBO(0, 0, 0, 0),
    ).chain(CurveTween(curve: Curves.linear)).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          color: _colorAnimation.value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
