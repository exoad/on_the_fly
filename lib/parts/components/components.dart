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
