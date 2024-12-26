import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/theme.dart';

class JobSimpleTextField extends StatelessWidget {
  final void Function(String str) onChanged;
  final String Function(String? str)? validator;
  final String canonicalLabel;
  final String hintLabel;
  final Widget? trailingChild;
  final Widget? leadingChild;

  const JobSimpleTextField(
      {super.key,
      required this.canonicalLabel,
      required this.hintLabel,
      this.trailingChild,
      this.leadingChild,
      required this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: IntrinsicWidth(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          autocorrect: false,
          decoration: InputDecoration(
              prefix: leadingChild,
              suffix: trailingChild,
              label: Text(canonicalLabel),
              hintText: hintLabel),
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
