import 'package:flutter/material.dart';
import 'package:on_the_fly/core/components/j_root.dart';
import 'package:on_the_fly/shared/theme.dart';

class JobTitle extends StatelessWidget implements JobRoot {
  final String title;

  const JobTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: kThemePrimaryFg1));
  }
}
