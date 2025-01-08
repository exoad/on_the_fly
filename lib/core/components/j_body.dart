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
  final void Function()? onStart;

  /// specifies whether a confirmation of any sort should be used when
  /// this job is requested for removal (this is only for client/user specified
  /// removal)
  final bool guardRemove;

  const JobBody(
      {super.key,
      required this.children,
      this.onStart,
      this.guardRemove = true,
      required this.onRemoveJob});

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
              const SizedBox(height: 21),
              Row(
                  spacing: kTotalAppMargin * 2,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton.icon(
                        style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                            iconColor: const WidgetStatePropertyAll<Color>(kTheme1),
                            foregroundColor: const WidgetStatePropertyAll<Color>(kTheme1),
                            side: const WidgetStatePropertyAll<BorderSide>(
                                BorderSide(color: kTheme1, width: 1))),
                        onPressed: widget.onRemoveJob,
                        icon: const Icon(Ionicons.trash_bin),
                        label: Text(Provider.of<InternationalizationNotifier>(context,
                                listen: false)
                            .i18n
                            .dispatchedJobs
                            .remove_job_button)),
                    TextButton.icon(
                        onPressed: widget.onStart,
                        icon: const Icon(Ionicons.play),
                        label: Text(
                            Provider.of<InternationalizationNotifier>(context)
                                .i18n
                                .appGenerics
                                .start,
                            style: const TextStyle(fontWeight: FontWeight.w600)))
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
