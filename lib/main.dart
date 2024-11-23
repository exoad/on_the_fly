import 'dart:io';

import 'package:auto_img/parts/app_view.dart';
import 'package:auto_img/shared/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) {
    exit(-1);
  } else {
    initConsts().then((_) {
      runApp(const AppView());
    });
  }
}
