import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/components/prefers.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

final class JobState with ChangeNotifier {
  static const String kInputFileEpKey = "input_files";
  static const String kOutputBuilderEpKey = "output_builder";

  final Map<String, dynamic> _pool;

  JobState() : _pool = <String, dynamic>{};

  void setEntry(String variable, dynamic object) {
    _pool[variable] = object;
    notifyListeners();
    logger.info("JobState#$hashCode: $variable = $object");
    logger.config("JobState#$hashCode WHOLE: $_pool");
  }

  dynamic operator [](String variable) {
    return _pool[variable];
  }

  Iterable<MapEntry<String, dynamic>> get entries => _pool.entries;

  bool contains(String variable) => _pool.containsKey(variable);
}

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
    return ChangeNotifierProvider<JobState>(
      create: (BuildContext context) => JobState(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 14,
          children: <Widget>[
            const SizedBox(height: 8),
            ...widget.children,
            const SizedBox(height: 4),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PrefersTextButtonIcon(
                      onPressed: () {},
                      icon: const Icon(Ionicons.eye),
                      label: Text(Provider.of<InternationalizationNotifier>(context,
                              listen: false)
                          .i18n
                          .appGenerics
                          .visualize)),
                  const Spacer(),
                  PrefersTextButtonIcon(
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                            backgroundColor: const WidgetStatePropertyAll<Color>(kTheme1),
                          ),
                      onPressed: widget.onRemoveJob,
                      icon: const Icon(Ionicons.trash_bin),
                      label: Text(Provider.of<InternationalizationNotifier>(context,
                              listen: false)
                          .i18n
                          .dispatchedJobs
                          .remove_job_button)),
                  const SizedBox(width: kTotalAppMargin * 2),
                  PrefersTextButtonIcon(
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                          backgroundColor: const WidgetStatePropertyAll<Color>(kTheme2)),
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
