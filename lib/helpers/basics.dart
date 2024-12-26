// just a bunch of a helper and "macro"-ish functions

import 'package:flutter/material.dart';

@pragma("vm:prefer-inline")
void wbpfcb(void Function(Duration timestamp) fx) {
  WidgetsBinding.instance.addPostFrameCallback(fx);
}

enum FileSelectionMode { folder, file }
