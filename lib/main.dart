import 'dart:io';

import 'package:on_the_fly/core/convert_job.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/e_focus.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/parts/app_view.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) {
    exit(-1);
  } else {
    initConsts().then((_) {
      // i know i prob shldnt have "unit tests" in production level code LOL
      if (kRunTests) {
        __tests();
      }
      logger.info("Registered jobs: ${Jobs.registeredJobs}");
      for (MapEntry<JobFocusMedium, Iterable<Jobs>> entry
          in Jobs.getJobsByMediumMap.entries) {
        logger.info(
            "Jobs for medium ${entry.key}: ${entry.value.length}");
      }
      runApp(const AppView());
      doWhenWindowReady(appWindow.show);
    });
  }
}

void __tests() {
  // Test OutputNameBuilder.simpleRandomName
  test(
      "Test OutputNameBuilder.simpleRandomName",
      () => OutputNameBuilder.simpleRandomName(len: 10)(
          "test.jpg", ImgFileTypes.png),
      null);
  // Test OutputNameBuilder.simpleName
  test(
      "Test OutputNameBuilder.simpleName",
      () => OutputNameBuilder.simpleName(name: "amogus")(
          "test.jpg", ImgFileTypes.png),
      ".\\amogus.png");
  // Test OutputNameBuilder.simplePrefix
  test(
      "Test OutputNameBuilder.simplePrefix",
      () => OutputNameBuilder.simplePrefix(prefix: "test_")(
          "bbbbb.jpg", ImgFileTypes.png),
      ".\\test_bbbbb.png");
  // Test AutoImgStrings.formalize
  test("Test AutoImgStrings.formalize", () => "test_test".formalize,
      "Test Test");
}

void test<E>(String testName, E Function() ax, E? expected) {
  E res = ax();
  logger.info(
      "${expected == null || res == expected ? "[OK]" : "[XX] got '$res', expected '$expected' "} - $testName ");
}
