import 'dart:io';

// import 'package:flutter/rendering.dart';
import 'package:objectid/objectid.dart';
import 'package:on_the_fly/base/ephemeral.dart';
import 'package:on_the_fly/base/native_channel.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/client/app_view.dart';
import 'package:on_the_fly/client/events/debug_events.dart';
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
      for (MapEntry<Type, Iterable<JobDispatcher>> entry
          in JobDispatcher.getJobsByMediumMap.entries) {
        logger.info("Jobs for medium ${entry.key}: ${entry.value.length}");
      }
//       debugRepaintRainbowEnabled = true;
      runApp(const AppView());
      doWhenWindowReady(() {
        appWindow.show();
        DebugLayerEvents()["xt"] = Wrap(
          spacing: 4,
          runSpacing: 4,
          children: XtRunners.r(),
        );
      }); // for bitsdojo_window
    });
    _sandbox();
  }
}

void _sandbox() {
  for (int i = 0; i < 100; i++) {
    logger.info("6f626a_${ObjectId().hexString}");
  }
}

/// runs the default tests builtin to the app
void __tests() {
  // Test OutputNameBuilder.simpleRandomName
  AppDebug().test(
      "Test OutputNameBuilder.simpleRandomName",
      () => OutputNameBuilder.simpleRandomName(len: 10)(
          "test.jpg", ImageMedium.instance["png"]),
      null);
  // Test OutputNameBuilder.simpleName
  AppDebug().test(
      "Test OutputNameBuilder.simpleName",
      () => OutputNameBuilder.simpleName(name: "amogus")(
          "test.png", ImageMedium.instance["jpg"]),
      ".\\amogus.jpg");
  // Test OutputNameBuilder.simplePrefix
  AppDebug().test(
      "Test OutputNameBuilder.simplePrefix",
      () => OutputNameBuilder.simplePrefix(prefix: "test_")(
          "bbbbb.jpg", ImageMedium.instance["png"]),
      ".\\test_bbbbb.png");
  // Test AutoImgStrings.formalize
  AppDebug().test("Test AutoImgStrings.formalize", () => "test_test".formalize,
      "Test Test");
}
