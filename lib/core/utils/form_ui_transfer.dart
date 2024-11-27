import 'package:flutter/material.dart';

abstract class UIPump<A> {
  final String label;
  final A defaultValue;

  UIPump({required this.label, required this.defaultValue});

  Widget buildUI(BuildContext context);
}

class StringInputPump extends UIPump<String> {
  final void Function(String input) pump;
  final String? Function(String? input) validator;

  StringInputPump(
      {required this.pump,
      required super.label,
      super.defaultValue = "",
      this.validator = _defaultValidator});

  static String? _defaultValidator(String? input) {
    return null;
  }

  @override
  Widget buildUI(BuildContext context) {
    return TextFormField(
      onChanged: pump,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
