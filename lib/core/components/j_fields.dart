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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (leadingChild != null) leadingChild!,
        Text(canonicalLabel,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: TextFormField(
              style: const TextStyle(fontSize: 14, fontFamily: kDefaultFontFamily),
              autovalidateMode: AutovalidateMode.always,
              autocorrect: false,
              decoration: InputDecoration(hintText: hintLabel),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ),
        if (trailingChild != null)
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: trailingChild!,
          )
      ],
    );
  }
}
