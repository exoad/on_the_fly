import 'package:flutter/material.dart';
import 'package:on_the_fly/frontend/components/debug_sized.dart';
import 'package:on_the_fly/shared/layout.dart';

class JobBody extends StatelessWidget {
  final List<Widget> children;

  const JobBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DebugBorderWidget(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children),
      ),
    );
  }
}
