// just a bunch of a helper and "macro"-ish functions

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';

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

extension MMap<K, V> on Map<K, V> {
  /// this might return null because the key might exist
  V? getOrDefault(K key, V value) {
    if (containsKey(key)) {
      return this[key];
    }
    return value;
  }

  V? computeIfAbsent(K key, V Function() function) {
    if (containsKey(key)) {
      return this[key];
    }
    return function();
  }
}

List<Alignment> get alignmentValues => const <Alignment>[
      Alignment.topRight,
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.bottomCenter,
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight
    ];

extension LList<T> on List<T> {
  /// caution: dont run this on an empty list !!! O_O
  T pickRandom() => this[random.nextInt(length)];
}
