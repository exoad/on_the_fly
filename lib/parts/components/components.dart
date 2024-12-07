import 'package:flutter/material.dart';

/// just a simple wrapper around container's margin property to be used like
/// the normal [Padding] widget
class Margin extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final Widget? child;

  const Margin({super.key, required this.margin, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, child: child);
  }
}

/// should only be used in the debug_layer_view section
/// of the app, nowhere else
class CompactTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const CompactTextButton(this.text, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: InkWell(
          child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(text, style: const TextStyle(color: Colors.white))),
        ));
  }
}
