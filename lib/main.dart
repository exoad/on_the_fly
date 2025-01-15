import 'dart:io';

// import 'package:flutter/rendering.dart';
import 'package:on_the_fly/base/win_man.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/client/tray/tray.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/client/load_it_n_view.dart';
import 'package:on_the_fly/client/root_service_view.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/client/app_view.dart';
import 'package:on_the_fly/client/events/debug_events.dart';
// import 'package:on_the_fly/frontend/events/debug_events.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/bundles.dart';
import 'package:on_the_fly/xt.dart';

// import 'core/formats/formats.dart';

/// main entry point for the app
void main() {
  AppDebug().startUpTimestamp = DateTime.now()
      .millisecondsSinceEpoch; // this isnt that important, but it might be useful lol for calculating how long the user might have had this app up for
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) {
    // pls dont build for these platforms LOL (idrk what happens, prob j build dependency errors)
    exit(-1);
  } else {
    initConsts().then((_) async {
      // i know i prob shldnt have "unit tests" in production level code LOL
      if (kRunTests) {
        logger.warning("Running internal tests !");
        __tests();
      }
      logger.info("kShowDebugView=$kShowDebugView");
      // debugRepaintRainbowEnabled = true;
      // for (int i = 0; i < 2; i++) {
      //   LoaderHandlerView.loads["TestDelay$i"] =
      //       () => Future<void>.delayed(const Duration(milliseconds: 400));
      // }
      LoaderHandlerView.loads["Load all asset bundles"] = Bundles.loadAllBundles;
      LoaderHandlerView.loads["Parse configurations"] = PublicBundle.parseConfigurations;
      LoaderHandlerView.loads["Initialize convertor"] = ConversionService.init;
      LoaderHandlerView.loads["WinMan Module Load"] = () {
        if (PublicBundle.isInitialFocused) {
          WinMan.I.requestFocus();
        }
      };
      runApp(RootServiceView(
        appView: const AppView(),
        onDone: () async {
          String? initWinState = PublicBundle.initialWindowState;
          doWhenWindowReady(() async {
            logger.fine("initWinState=$initWinState");
            if (initWinState == null || initWinState == "gui") {
              appWindow.show();
              WinMan.I.setTitle(
                  InternationalizationNotifier().i18n.appGenerics.canonical_title);
            }
            DebugLayerEvents()["xt"] = Wrap(
              spacing: 4,
              runSpacing: 4,
              children: XtRunners.r(),
            );
          }); // for bitsdojo_window
          await initSystemTray();
        },
      ));
    });
  }
}

/// runs the default tests builtin to the app
void __tests() {
  // // Test OutputNameBuilder.simpleRandomName
  // AppDebug().test(
  //     "Test OutputNameBuilder.simpleRandomName",
  //     () => OutputNameBuilder.simpleRandomName(len: 10)(
  //         "test.jpg", ImageMedium.I["png"]),
  //     null);
  // // Test OutputNameBuilder.simpleName
  // AppDebug().test(
  //     "Test OutputNameBuilder.simpleName",
  //     () => OutputNameBuilder.simpleName(name: "amogus")(
  //         "test.png", ImageMedium.I["jpg"]),
  //     ".\\amogus.jpg");
  // // Test OutputNameBuilder.simplePrefix
  // AppDebug().test(
  //     "Test OutputNameBuilder.simplePrefix",
  //     () => OutputNameBuilder.simplePrefix(prefix: "test_")(
  //         "bbbbb.jpg", ImageMedium.I["png"]),
  //     ".\\test_bbbbb.png");
  // Test AutoImgStrings.formalize
  AppDebug()
      .test("Test AutoImgStrings.formalize", () => "test_test".formalize, "Test Test");
}
