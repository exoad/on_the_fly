import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';

/// very naive event dispatcher for dbeug_layer_view
class DebugLayerEvents with ChangeNotifier {
  static final DebugLayerEvents _instance = DebugLayerEvents.internal();

  @protected
  DebugLayerEvents.internal() : _values = <String, dynamic>{};

  final Map<String, dynamic> _values;

  /// returns a singleton instance
  factory DebugLayerEvents() => _instance;

  String? operator [](String key) => _values[key];

  void operator []=(String key, dynamic value) {
    _values[key] = value;
    logger.info("DebugView: $key=$value");
    if (kShowDebugView) {
      notifyListeners();
    }
  }

  Map<String, dynamic> get dump => _values;
}

@pragma("vm:prefer-inline")
DebugLayerEvents debugSeek() => DebugLayerEvents();
