// just a bunch of a helper and "macro"-ish functions

import 'package:flutter/material.dart';

@pragma("vm:prefer-inline")
void pfcb(void Function(Duration timestamp) fx) {
  WidgetsBinding.instance.addPostFrameCallback(fx);
}
