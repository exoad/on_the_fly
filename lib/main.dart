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
      if (kRunTests) {
        __tests();
      }
      runApp(const AppView());
    });
  }
}

void __tests() {
  // Test OutputNameBuilder.simpleRandomName
  final OutputPathHandler simpleRandomName =
      OutputNameBuilder.simpleRandomName(len: 10);
  test("Test OutputNameBuilder.simpleRandomName",
      () => simpleRandomName("test.jpg", ImgFileTypes.png), null);
  // Test OutputNameBuilder.simpleName
  final OutputPathHandler simpleName =
      OutputNameBuilder.simpleName(name: "amogus");
  test(
      "Test OutputNameBuilder.simpleName",
      () => simpleName("test.jpg", ImgFileTypes.png),
      ".\\amogus.png");
  // Test OutputNameBuilder.simplePrefix
  final OutputPathHandler simplePrefix =
      OutputNameBuilder.simplePrefix(prefix: "test_");
  test(
      "Test OutputNameBuilder.simplePrefix",
      () => simplePrefix("bbbbb.jpg", ImgFileTypes.png),
      ".\\test_bbbbb.png");
}

void test<E>(String testName, E Function() ax, E? expected) {
  E res = ax();
  print(
      "${expected == null || res == expected ? "[OK]" : "[XX] got '$res', expected '$expected' "} - $testName ");
}
