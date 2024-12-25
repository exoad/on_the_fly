import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/shared/layout.dart';
// import 'package:on_the_fly/shared/theme.dart';

class JobBody extends StatelessWidget {
  final List<Widget> children;

  const JobBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...children,
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 8),
            //       child: Divider(color: kThemePrimaryFg2.withAlpha(120), thickness: 1.0),
            //     ),
            const SizedBox(height: 8),
            Row(
                spacing: kTotalAppMargin,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: OutlinedButton.icon(
                          label: const Text("Remove Job"),
                          icon: const Icon(Ionicons.close),
                          onPressed: () {})),
                  Expanded(
                      child: TextButton(child: const Text("Sigma"), onPressed: () {}))
                ])
          ]),
    );
  }
}
