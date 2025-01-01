import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

const String _kGenericFileImagesPath = "assets/icons";

final List<_GenericFileTypeDisplay> _allAssets = <_GenericFileTypeDisplay>[
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_file.png"),
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_archive.png"),
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_audio.png"),
  _GenericFileTypeDisplay("$_kGenericFileImagesPath/generic_image.png"),
];

class _GenericFileTypeDisplay {
  final String asset;
  double vert;
  double z;
  double rotX;

  _GenericFileTypeDisplay(this.asset)
      : z = 0,
        rotX = 0,
        vert = 0;
}

class LoaderHandlerView extends StatefulWidget {
  const LoaderHandlerView({super.key});

  @override
  State<LoaderHandlerView> createState() => _LoaderHandlerViewState();
}

class _LoaderHandlerViewState extends State<LoaderHandlerView> {
  @override
  void initState() {
    super.initState();
    appWindow.size = kLoadingWindowSize;
    appWindow.minSize =
        kLoadingWindowSize; // this might have some adverse effects, if we dont remove it or do something in dispose()
  }

  @override
  void dispose() {
    appWindow.size = kDefaultAppWindowSize;
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
                  const LoaderSpinner(),
                  const SizedBox(height: 69), // funny number for real !
                  Text(
                      Provider.of<InternationalizationNotifier>(context)
                          .i18n
                          .appGenerics
                          .loading,
                      style: const TextStyle(
                          fontSize: 20,
                          color: kThemePrimaryFg1,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )),
      ),
    );
  }
}

class LoaderSpinner extends StatefulWidget {
  const LoaderSpinner({
    super.key,
  });

  @override
  State<LoaderSpinner> createState() => _LoaderSpinnerState();
}

class _LoaderSpinnerState extends State<LoaderSpinner> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 760))
          ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(_allAssets.first.asset,
        width: kLoaderIconSize, height: kLoaderIconSize);
  }
}
