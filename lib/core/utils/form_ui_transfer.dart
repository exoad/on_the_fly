import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UIForm {
  final List<UIPump<dynamic>> pumps;
  final String title;
  late int hash;

  UIForm({required this.pumps, required this.title}) {
    hash = _calculateHash(pumps, title);
  }

  static int _calculateHash(
      List<UIPump<dynamic>> pumps, String title) {
    return Object.hash(title, DateTime.now().millisecondsSinceEpoch,
        pumps.map((UIPump<dynamic> pump) => pump.label).join(';'));
  }
}

abstract class UIPump<A> {
  final String label;
  final A defaultValue;

  UIPump({required this.label, required this.defaultValue});

  Widget buildUI(BuildContext context);

  @override
  String toString() =>
      'UIPump(label: $label, defaultValue: $defaultValue)';
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
