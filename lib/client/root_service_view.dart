import 'package:flutter/material.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:provider/provider.dart';

class LoadIt {
  final Future<void> Function() action;
  final String displayName;

  const LoadIt(this.displayName, this.action);

  /// used like the standard implied () operator
  void call() => action();
}

/// main widget that launchs other views. it is a "servicer" widget since it
/// manages switching from [LoaderHandlerView] to [AppView] (or any other
/// subsequently provided widgets)
class RootServiceView extends StatelessWidget {
  final Widget loadingView;
  final Widget appView;
  final List<LoadIt> loads;

  const RootServiceView(
      {super.key,
      this.loadingView = const SizedBox.expand(),
      required this.appView,
      required this.loads});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InternationalizationNotifier>(
        lazy: true, create: (_) => InternationalizationNotifier(), child: loadingView);
  }
}
