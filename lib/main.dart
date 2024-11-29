import 'dart:io';

import 'package:on_the_fly/core/output_builder.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/parts/app_view.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

/// main entry point for the app
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) {
    // pls dont build for these platforms LOL (idrk what happens, prob j build dependency errors)
    exit(-1);
  } else {
    initConsts().then((_) {
      // i know i prob shldnt have "unit tests" in production level code LOL
      if (kRunTests) {
        __tests();
      }
      logger.info("Registered jobs: ${Jobs.registeredJobs}");
      // lets do a sanity check for all of the registered jobs just in case
      for (MapEntry<String, Iterable<Jobs<FileFormat>>> entry
          in Jobs.getJobsByMediumMap.entries) {
        logger.info("Jobs for medium ${entry.key}: ${entry.value.length}");
      }
      runApp(const AppView());
      doWhenWindowReady(appWindow.show); // for bitsdojo_window
    });
  }
}

void __tests() {
  // Test OutputNameBuilder.simpleRandomName
  test(
      "Test OutputNameBuilder.simpleRandomName",
      () => OutputNameBuilder.simpleRandomName(len: 10)(
          "test.jpg", ImageMedium.inst["png"]),
      null);
  // Test OutputNameBuilder.simpleName
  test(
      "Test OutputNameBuilder.simpleName",
      () => OutputNameBuilder.simpleName(name: "amogus")(
          "test.jpg", ImageMedium.inst["jpg"]),
      ".\\amogus.png");
  // Test OutputNameBuilder.simplePrefix
  test(
      "Test OutputNameBuilder.simplePrefix",
      () => OutputNameBuilder.simplePrefix(prefix: "test_")(
          "bbbbb.jpg", ImageMedium.inst["png"]),
      ".\\test_bbbbb.png");
  // Test AutoImgStrings.formalize
  test("Test AutoImgStrings.formalize", () => "test_test".formalize,
      "Test Test");
}

/// the most basic test function possible LOL, im sorry, not gonna
/// use a testing framework for this, not necessary imo (yuh)
void test<E>(String testName, E Function() ax, E? expected) {
  E res = ax();
  logger.info(
      "${expected == null || res == expected ? "[OK]" : "[XX] got '$res', expected '$expected' "} - $testName ");
}
