import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/bundles.dart';

/// replicates [TextButton.icon] with respect to [PublicBundle.preferDenseActionables] context
///
/// drop in replacement
class PrefersTextButtonIcon extends StatelessWidget {
  final ButtonStyle? style;
  final Widget label;
  final Widget icon;
  final FocusNode? focusNode;
  final void Function()? onPressed;

  const PrefersTextButtonIcon(
      {super.key,
      this.style,
      this.focusNode,
      required this.label,
      required this.icon,
      this.onPressed});

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

/// replicates [OutlinedButton.icon] with respect to [PublicBundle.preferDenseActionables] context
///
/// drop in replacement
class PrefersOutlinedButtonIcon extends StatelessWidget {
  final ButtonStyle? style;
  final Widget label;
  final Widget icon;
  final FocusNode? focusNode;
  final void Function()? onPressed;

  const PrefersOutlinedButtonIcon(
      {super.key,
      this.style,
      this.focusNode,
      required this.label,
      required this.icon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: onPressed,
        focusNode: focusNode,
        label: PublicBundle.preferDenseActionables ? icon : label,
        icon: PublicBundle.preferDenseActionables ? null : icon,
        style: style);
  }
}
