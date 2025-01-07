import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

// import 'package:on_the_fly/shared/theme.dart';

class JobBody extends StatefulWidget {
  final List<Widget> children;
  final void Function() onRemoveJob;

  const JobBody({super.key, required this.children, required this.onRemoveJob});

  @override
  State<JobBody> createState() => _JobBodyState();
}

class _JobBodyState extends State<JobBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...widget.children,
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
                            backgroundColor:
                                const WidgetStatePropertyAll<Color>(kTheme1)),
                        label: Text(Provider.of<InternationalizationNotifier>(context,
                                listen: false)
                            .i18n
                            .dispatchedJobs
                            .remove_job_button),
                        icon: const Icon(Ionicons.close),
                        onPressed: widget.onRemoveJob),
                  ])
            ]),
      ),
    );
  }
}

// tries to replicate the look of the given expansiontile themedata
class JobContainer extends StatelessWidget {
  final Widget child;

  const JobContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: Theme.of(context).listTileTheme.contentPadding,
        decoration: BoxDecoration(
            color: kThemeTilePrimary,
            border: Border.all(color: kThemeOptedComponentBorder, width: 1.5),
            borderRadius: BorderRadius.circular(kRRArc)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: child,
        ));
  }
}

class JobTileContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;

  const JobTileContainer(
      {super.key, required this.title, required this.subtitle, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return JobContainer(
        child: Row(children: <Widget>[
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(fontSize: 18)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: kThemePrimaryFg2)),
          ]),
      const Spacer(),
      trailing,
    ]));
  }
}
