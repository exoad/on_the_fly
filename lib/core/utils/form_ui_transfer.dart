// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OrderForm {
  /// pumps are basically hard defined ui elements
  final Map<String, UIPump<dynamic>> pumps;

  final void Function() onOrder;

  final bool Function() isAlive;

  /// this is the title of the form (canonical !!)
  final String title;

  /// represents a runtime id (not persistent and shld stay like that)
  late final int hash;

  OrderForm(
      {required this.pumps,
      required this.title,
      required this.onOrder,
      required this.isAlive}) {
    hash = _calculateHash(pumps, title);
  }

  static int _calculateHash(Map<String, UIPump<dynamic>> pumps, String title) {
    return Object.hash(title, DateTime.now().millisecondsSinceEpoch,
        pumps.values.map((UIPump<dynamic> pump) => pump.toString()));
  }

  @override
  String toString() => 'OrderForm(pumps: $pumps, title: $title, hash: $hash)';
}

abstract class UIPump<A> {
  final String label;
  final A defaultValue;

  UIPump({required this.label, required this.defaultValue});

  Widget buildUI(covariant BuildContext context);

  A get value;

  @override
  String toString() => 'UIPump(label: $label, defaultValue: $defaultValue)';
}

class StringInputPump extends UIPump<String> {
  final void Function(String input) pump;
  final String? Function(String? input) validator;
  String _v = "";

  StringInputPump(
      {required this.pump,
      required super.label,
      super.defaultValue = "",
      this.validator = _defaultValidator});

  static String? _defaultValidator(String? input) {
    return null;
  }

  @override
  String get value => _v;

  @override
  Widget buildUI(covariant BuildContext context) {
    return TextFormField(
      onChanged: (String? v) {
        _v = v ?? "";
        pump(_v);
      },
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  @override
  String toString() => 'StringInputPump(pump: $pump, validator: $validator)';
}
