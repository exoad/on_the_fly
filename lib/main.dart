import 'dart:io';

import 'package:auto_img/core/core.dart';
import 'package:auto_img/parts/app_view.dart';
import 'package:auto_img/shared/app.dart';
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
      runApp(const AppView());
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
}

void test<E>(String testName, E Function() ax, E? expected) {
  E res = ax();
  logger.info(
      "${expected == null || res == expected ? "[OK]" : "[XX] got '$res', expected '$expected' "} - $testName ");
}
