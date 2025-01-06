import 'package:flutter/material.dart';
import 'package:on_the_fly/core/components/job_component.dart';

class SpinnerChip<T> {
  final String title;
  final Widget? icon;
  final T obj;

  const SpinnerChip({required this.title, this.icon, required this.obj});
}

class JobSimpleSpinner<T> extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<SpinnerChip<T>> chips;
  final void Function(T chip) onSelect;

  const JobSimpleSpinner(
      {super.key,
      required this.chips,
      required this.onSelect,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return JobTileContainer(
      title: title,
      subtitle: subtitle,
      trailing: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
