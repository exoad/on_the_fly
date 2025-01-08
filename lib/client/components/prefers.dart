import 'dart:async';

import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/bundles.dart';

class PrefersTextButtonIcon extends StatelessWidget {
  final ButtonStyle? style;
  final Widget label;
  final Widget icon;
  final FocusNode? focusNode;
  final FutureOr<void> Function() onPressed;

  const PrefersTextButtonIcon(
      {super.key,
      this.style,
      this.focusNode,
      required this.label,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        focusNode: focusNode,
        label: PublicBundle.preferDenseActionables ? icon : label,
        icon: PublicBundle.preferDenseActionables ? null : icon,
        style: style);
  }
}
