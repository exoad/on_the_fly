import 'dart:async';

import 'package:flutter/material.dart';
import 'package:on_the_fly/client/root_service_view.dart';
import 'package:provider/provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:on_the_fly/client/components/c_canvas.dart'; // Assuming this contains your custom painter
import 'package:on_the_fly/client/components/kinetic_carousel.dart'; // Assuming this is your carousel widget
import 'package:on_the_fly/client/events/ephemeral_stacks.dart'; // Assuming this is your stack-related logic
import 'package:on_the_fly/shared/layout.dart'; // Assuming layout and constants are here

const String _kGenericFileImagesPath = "assets/icons";
const double _kEphemeralLoadingIconSz = 80;

const List<_GenericFileTypeDisplay> _allAssets = <_GenericFileTypeDisplay>[
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_file.png"),
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_archive.png"),
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_audio.png"),
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_image.png"),
];

class _GenericFileTypeDisplay extends StatelessWidget {
  final String asset;

  const _GenericFileTypeDisplay(this.asset);

  @override
  Widget build(BuildContext context) {
    return Image.asset(asset,
        width: _kEphemeralLoadingIconSz, height: _kEphemeralLoadingIconSz);
  }
}

class LoaderHandlerView extends StatefulWidget implements LoadItServicer {
  static Map<String, FutureOr<void> Function()> loads =
      <String, FutureOr<void> Function()>{};
  final void Function()? onDone;

  const LoaderHandlerView({super.key, this.onDone});

  static Iterable<MapEntry<String, FutureOr<void> Function()>> get loadEntries =>
      loads.entries;

  @override
  State<LoaderHandlerView> createState() => _LoaderHandlerViewState();
}

class _LoaderHandlerViewState extends State<LoaderHandlerView>
    with SingleTickerProviderStateMixin {
  int completed = 1;
  late AnimationController animationController;
  late Animation<double> progressAnim;
  String? currentMessage;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    appWindow.size = kLoadingWindowSize;
    appWindow.minSize = kLoadingWindowSize;
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    progressAnim = Tween<double>(begin: 0, end: 0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    processLoads();
  }

  void processLoads() async {
    for (MapEntry<String, FutureOr<void> Function()> entry
        in LoaderHandlerView.loadEntries) {
      await entry.value();
      setState(() {
        currentMessage = entry.key;
        _progress(++completed / (LoaderHandlerView.loads.length + 1));
      });
    }
    widget.onDone?.call(); // no use of syntax sugar :)
  }

  void _progress(double target) {
    progressAnim = Tween<double>(begin: progress, end: target)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    progress = target;
    animationController.reset();
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(kTotalAppMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: KineticCarouselAnimator(
                      period: KineticCarouselAnimator.kPeriod,
                      radius: _kEphemeralLoadingIconSz * 0.9,
                      allowScalingUpAnimation: true,
                      scaleUpAnimationDelay:
                          KineticCarouselAnimator.kScaleUpAnimationDelay,
                      scaleUpAnimationDuration:
                          KineticCarouselAnimator.kScaleUpAnimationDuration,
                      scaleUpCurve: Curves.easeInOutSine,
                      scaleUpFactor: KineticCarouselAnimator.kScaleUpFactor,
                      scaleUpPeriod: KineticCarouselAnimator.kScaleUpPeriod,
                      children: _allAssets,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            Provider.of<InternationalizationNotifier>(context)
                                .i18n
                                .appGenerics
                                .loading,
                            style: TextStyle(
                                fontSize: 20,
                                color: kThemePrimaryFg1,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(currentMessage ?? "...",
                            style: TextStyle(fontSize: 14, color: kThemePrimaryFg2)),
                        const Spacer(),
                        AnimatedBuilder(
                            animation: progressAnim,
                            builder: (BuildContext context, Widget? child) {
                              return CustomPaint(
                                  size: Size(
                                      kLoadingWindowSize.width - (kTotalAppMargin * 2),
                                      4),
                                  painter: GradientProgressBarPainter(
                                      // progress: completed /
                                      //     (LoaderHandlerView.loads.length + 1),
                                      progress: progressAnim.value,
                                      progressGradient: LinearGradient(
                                          colors: <Color>[kTheme1, kTheme2],
                                          stops: const <double>[0.36, 0.8],
                                          begin: Alignment.topLeft,
                                          end: Alignment.centerRight),
                                      trackColor: kThemeBg));
                            })
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
