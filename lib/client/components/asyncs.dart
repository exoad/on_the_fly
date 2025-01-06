import 'dart:async';

import 'package:flutter/material.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/helpers/basics.dart';
import 'package:provider/provider.dart';

enum AsyncFormStates { VALIDATING, INVALID, VALID, NOTHING }

/// a more robust and customizable version of https://pub.dev/packages/async_textformfield
class AsyncTextFormField extends StatefulWidget {
  final Future<String?> Function(String? value) validator;
  final void Function(String value)? onChanged;
  final Widget Function(AsyncFormStates state)? suffixIconBuilder;
  final TextStyle? style;
  final Duration validationDebounce;
  final TextEditingController? controller;
  final StrutStyle? strutStyle;
  final String? validatingMessage;
  final TextAlign textAlign;
  final Color? cursorColor;
  final double cursorWidth;
  final bool expands;
  final String? initialValue;
  final int maxLines;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextDirection? textDecoration;

  const AsyncTextFormField(
      {super.key,
      required this.validator,
      this.style,
      this.initialValue,
      this.onChanged,
      this.decoration,
      this.strutStyle,
      this.focusNode,
      this.suffixIconBuilder,
      this.textAlign = TextAlign.start,
      required this.validationDebounce,
      this.controller,
      this.cursorWidth = 2,
      this.textDecoration,
      this.maxLines = 1,
      this.expands = false,
      this.cursorColor,
      this.validatingMessage});

  @override
  State<AsyncTextFormField> createState() {
    return _AsyncTextFormField();
  }
}

class _AsyncTextFormField extends State<AsyncTextFormField> {
  Timer? debouncer;
  bool validating = false;
  bool isValid = false;
  bool locked = false;
  bool isDirty = false;
  String? _hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      textInputAction: TextInputAction.next,
      textAlign: widget.textAlign,
      cursorWidth: widget.cursorWidth,
      initialValue: widget.initialValue,
      textDirection: widget.textDecoration,
      strutStyle: widget.strutStyle,
      focusNode: widget.focusNode,
      expands: widget.expands,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (validating) {
          return widget.validatingMessage ??
              Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .appGenerics
                  .validating;
        } else if (!locked && !isValid) {
          return _hint ??
              Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .appGenerics
                  .incorrect;
        }
        return null;
      },
      decoration: widget.decoration?.copyWith(
          suffix: widget.suffixIconBuilder?.call(validating
              ? AsyncFormStates.VALIDATING
              : !isValid && isDirty
                  ? AsyncFormStates.INVALID
                  : isValid
                      ? AsyncFormStates.VALID
                      : AsyncFormStates.NOTHING)),
      onChanged: (String value) async {
        isDirty = true;
        locked = true;
        cancelTimer();
        debouncer = Timer(widget.validationDebounce, () async {
          locked = false;
          setState(() => validating = true);
          _hint = await widget.validator(value);
          isDirty = _hint != null;
          setState(IGNORE_INVOKE);
          validating = false;
        });
      },
    );
  }

  @pragma("vm:prefer-inline")
  void cancelTimer() {
    if (debouncer?.isActive ?? false) {
      debouncer?.cancel();
    }
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }
}
