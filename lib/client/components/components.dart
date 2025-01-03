import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';

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

/// macro class
class ThemeableTextButton extends TextButton {
  ThemeableTextButton(
      {super.key,
      required super.onPressed,
      required super.child,
      required Color bg,
      TextStyle? textStyle,
      required Color fg})
      : super(
            style: ButtonStyle(
                iconColor: WidgetStatePropertyAll<Color>(fg),
                textStyle:
                    WidgetStatePropertyAll<TextStyle>(textStyle ?? TextStyle(color: fg)),
                backgroundColor: WidgetStatePropertyAll<Color>(bg)));
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

/// a dialog with a blurred background
class ImportanceDialog extends StatelessWidget {
  final Widget child;

  const ImportanceDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Padding(
                padding: const EdgeInsets.all(kJobDispatcherFormScaffoldMargin),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kThemePrimaryFg1),
                        borderRadius: BorderRadius.circular(kRRArc)),
                    height: MediaQuery.sizeOf(context).height * 0.74,
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // lol using the default value :D
                            child: child)
                        .blurry(
                            borderRadius: BorderRadius.circular(kRRArc),
                            blur: 12,
                            color: kThemeBg.withAlpha((0.45 * 255).round()))
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 200)))))
        .animate(delay: const Duration(milliseconds: 200))
        .slideY(
            begin: 0.08,
            end: 0,
            duration: const Duration(milliseconds: 440),
            curve: Curves.ease)
        .fadeIn(
            begin: 0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut);
  }
}
