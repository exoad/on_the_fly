import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:provider/provider.dart';

/// very naive event dispatcher for dbeug_layer_view
class DebugLayerEvents with ChangeNotifier {
  final Map<String, dynamic> _values;

  DebugLayerEvents() : _values = <String, dynamic>{};

  String? operator [](String key) => _values[key];

  void operator []=(String key, dynamic value) {
    _values[key] = value;
    notifyListeners();
  }

  Map<String, dynamic> get dump => _values;
}

class _FakeDebugLayerEvents extends DebugLayerEvents {
  @override
  String? operator [](String key) => null;

  @override
  void operator []=(String key, dynamic value) {}

  static final _FakeDebugLayerEvents fake = _FakeDebugLayerEvents();
}

@pragma("vm:prefer-inline")
DebugLayerEvents debugSeek(BuildContext context, [bool listen = true]) =>
    kShowDebugView
        ? Provider.of<DebugLayerEvents>(context, listen: listen)
        : _FakeDebugLayerEvents.fake;
