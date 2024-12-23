import 'dart:io';

// import 'package:flutter/rendering.dart';
import 'package:on_the_fly/base/ephemeral.dart';
import 'package:on_the_fly/base/native_channel.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/frontend/app_view.dart';
import 'package:on_the_fly/frontend/components/components.dart';
import 'package:on_the_fly/frontend/events/debug_events.dart';
// import 'package:on_the_fly/frontend/events/debug_events.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:on_the_fly/xt.dart';

import 'core/formats/formats.dart';

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
        __tests();
      }
      logger.info("kShowDebugView=$kShowDebugView");
      // checking platform channel exists
      if (!await AppEphemeral.sanityCheck()) {
        throw const NativeException(
            "OnTheFly unable to complete native channel sanity checks!");
      } else {
        logger.info("Platform channel registered");
      }
      logger.info("Registered jobs: ${JobDispatcher.registeredJobDispatchers}");
      // lets do a sanity check for all of the registered jobs just in case
      for (MapEntry<String, Iterable<JobDispatcher>> entry
          in JobDispatcher.getJobsByMediumMap.entries) {
        logger.info("Jobs for medium ${entry.key}: ${entry.value.length}");
      }
//       debugRepaintRainbowEnabled = true;
      runApp(const AppView());
      doWhenWindowReady(() {
        appWindow.show();
        DebugLayerEvents()["xt"] = const Wrap(
          spacing: 4,
          runSpacing: 4,
          children: <Widget>[
            CompactTextButton("fx1", onPressed: XtRunners.fx1),
            CompactTextButton("fx2", onPressed: XtRunners.fx2),
            // for (String locale in kDefinedLocales) // TODO: fix this pos of not working to change locales
            //   CompactTextButton("fx3_$locale", onPressed: () => XtRunners.fx3(locale))
          ],
        );
      }); // for bitsdojo_window
    });
  }
}

/// runs the default tests builtin to the app
void __tests() {
  // Test OutputNameBuilder.simpleRandomName
  AppDebug().test(
      "Test OutputNameBuilder.simpleRandomName",
      () => OutputNameBuilder.simpleRandomName(len: 10)(
          "test.jpg", ImageMedium.inst["png"]),
      null);
  // Test OutputNameBuilder.simpleName
  AppDebug().test(
      "Test OutputNameBuilder.simpleName",
      () => OutputNameBuilder.simpleName(name: "amogus")(
          "test.png", ImageMedium.inst["jpg"]),
      ".\\amogus.jpg");
  // Test OutputNameBuilder.simplePrefix
  AppDebug().test(
      "Test OutputNameBuilder.simplePrefix",
      () => OutputNameBuilder.simplePrefix(prefix: "test_")(
          "bbbbb.jpg", ImageMedium.inst["png"]),
      ".\\test_bbbbb.png");
  // Test AutoImgStrings.formalize
  AppDebug()
      .test("Test AutoImgStrings.formalize", () => "test_test".formalize, "Test Test");
}
