// just a bunch of a helper and "macro"-ish functions

import 'dart:math';

import 'package:flutter/material.dart';

void IGNORE_INVOKE() {}

int ISOLATE_EXIT_SIG = -69420; // hahahaha funny numero

@pragma("vm:prefer-inline")
void wbpfcb(void Function(Duration timestamp) fx) {
  WidgetsBinding.instance.addPostFrameCallback(fx);
}

final Random _rng = Random();

enum FileSelectionMode { folder, file }

@pragma("vm:prefer-inline")
int genRngTill(int unwanted, int maxRange) {
  int x = unwanted;
  while (x == unwanted) {
    x = _rng.nextInt(maxRange);
  }
  return x;
}
