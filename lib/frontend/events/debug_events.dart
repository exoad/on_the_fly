// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';

// import 'dart:async';

// // courtesy from code: https://medium.com/@matanlurey/building-a-reactive-fps-counter-in-dart-5f7c0177289e

// int _previous = DateTime.now().millisecondsSinceEpoch;

// /// A cross-platform implementation for requesting the next animation frame.
// ///
// /// Returns a [Future<num>] that completes as close as it can to the next
// /// frame, given that it will attempt to be called 60 times per second (60 FPS)
// /// by default - customize by setting the [target].
// Future<num> nextFrame([num target = 60]) {
//   final int current = DateTime.now().millisecondsSinceEpoch;
//   final int call = max(0, (1000 ~/ target) - (current - _previous));
//   return Future<num>.delayed(
//     Duration(milliseconds: call),
//     () => _previous = DateTime.now().millisecondsSinceEpoch,
//   );
// }

// /// Returns a [Stream] that fires every [animationFrame].
// ///
// /// May provide a function that returns a future completing in the next
// /// available frame. For example in a browser environment this may be delegated
// /// to `window.animationFrame`:
// ///
// /// ```
// /// eachFrame(animationFrame: () => window.animationFrame)
// /// ```
// Stream<num> eachFrame({Future<num> Function() animationFrame = nextFrame}) {
//   late StreamController<num> controller;
//   bool cancelled = false;
//   void onNext(num timestamp) {
//     if (cancelled) {
//       return;
//     }
//     controller.add(timestamp);
//     animationFrame().then(onNext);
//   }

//   controller = StreamController<num>(
//     sync: true,
//     onListen: () {
//       animationFrame().then(onNext);
//     },
//     onCancel: () {
//       cancelled = true;
//     },
//   );
//   return controller.stream;
// }

// /// Computes frames-per-second given a [Stream<num>] of timestamps.
// ///
// /// The resulting [Stream] is capped at reporting a maximum of 60 FPS.
// ///
// /// ```
// /// // Listens to FPS for 10 frames, and reports at FPS, printing to console.
// /// eachFrame()
// ///   .take(10)
// ///   .transform(const ComputeFps())
// ///   .listen(print);
// /// ```
// class ComputeFps implements StreamTransformer<num, num> {
//   final num _filterStrength;

//   /// Create a transformer.
//   ///
//   /// Optionally specify a `filterStrength`, or how little to reflect temporary
//   /// variations in FPS. A value of `1` will only keep the last value.
//   const ComputeFps([this._filterStrength = 20]);

//   @override
//   Stream<num> bind(covariant Stream<num> stream) {
//     late StreamController<num> controller;
//     late StreamSubscription<num> subscription;
//     num frameTime = 0;
//     num? lastLoop;
//     controller = StreamController<num>(
//       sync: true,
//       onListen: () {
//         subscription = stream.listen((num thisLoop) {
//           if (lastLoop != null) {
//             num thisFrameTime = thisLoop - lastLoop!;
//             frameTime += (thisFrameTime - frameTime) / _filterStrength;
//             controller.add(min(1000 / frameTime, 60));
//           }
//           lastLoop = thisLoop;
//         });
//       },
//       onCancel: () => subscription.cancel(),
//     );
//     return controller.stream;
//   }

//   @override
//   StreamTransformer<RS, RT> cast<RS, RT>() {
//     throw UnimplementedError();
//   }
// }

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
    if (!kSuppressDebugViewLogging) {
      logger.info("DebugView: $key=$value");
    }
    if (kShowDebugView) {
      notifyListeners();
    }
  }

  Map<String, dynamic> get dump => _values;
}

@pragma("vm:prefer-inline")
DebugLayerEvents debugSeek() => DebugLayerEvents();
