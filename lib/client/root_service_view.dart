import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/client/load_it_n_view.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:provider/provider.dart';

// marker interface
abstract class LoadItServicer implements Widget {}

/// main widget that launchs other views. it is a "servicer" widget since it
/// manages switching from [LoaderHandlerView] to [AppView] (or any other
/// subsequently provided widgets)
class RootServiceView extends StatelessWidget {
  final Widget appView;
  final FutureOr<void> Function()? onDone;

  const RootServiceView({super.key, required this.appView, this.onDone});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InternationalizationNotifier>(
        lazy: true,
        create: (_) => InternationalizationNotifier(),
        child: _Switcher(
          appView: appView,
          onDone: onDone,
        ));
  }
}

class _Switcher extends StatefulWidget {
  final Widget appView;
  final FutureOr<void> Function()? onDone;

  const _Switcher({required this.appView, this.onDone});

  @override
  State<_Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<_Switcher> {
  bool completed;

  _SwitcherState() : completed = false;

  @override
  Widget build(BuildContext context) {
    // no animations lets go !
    return completed
        ? widget.appView
        : LoaderHandlerView(onDone: () {
            appWindow.size = kDefaultAppWindowSize;
            setState(() => completed = true);
            widget.onDone?.call();
          });
  }
}
