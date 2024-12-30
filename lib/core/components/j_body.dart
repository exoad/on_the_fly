import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

// import 'package:on_the_fly/shared/theme.dart';

class JobBody extends StatelessWidget {
  final List<Widget> children;
  final void Function() onRemoveJob;

  const JobBody({super.key, required this.children, required this.onRemoveJob});

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
            const SizedBox(height: 24),
            Row(
                spacing: kTotalAppMargin,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton.icon(
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                          backgroundColor: const WidgetStatePropertyAll<Color>(kTheme1)),
                      label: Text(Provider.of<InternationalizationNotifier>(context,
                              listen: false)
                          .i18n
                          .dispatchedJobs
                          .remove_job_button),
                      icon: const Icon(Ionicons.close),
                      onPressed: onRemoveJob),
                ])
          ]),
    );
  }
}
