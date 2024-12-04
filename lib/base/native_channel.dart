import 'package:flutter/services.dart';
import 'package:on_the_fly/core/utils/result.dart';

/// very naive and basic method calling helpers for managing invoking
/// native side method channels
///
/// the functions here are meant to deal with result only channels, where
/// parameters are not really necessary
class BasicNativeChannel {
  BasicNativeChannel._();

  /// safely invokes a method that returns a bool from the native side
  ///
  /// [channel] - represents the native method channel to call
  ///
  /// [methodName] - target method name, make sure no typos exist and that the
  ///                native side and the dart side all match !!!
  static Future<Result<bool, String>> safeInvokeBool(
      MethodChannel channel, String methodName) async {
    bool? res;
    try {
      res = await channel.invokeMethod<bool>(methodName);
    } on PlatformException catch (e) {
      return Result<bool, String>.bad("safeInvokeBool failed: ${e.message}");
    }
    return res == null
        ? Result<bool, String>.bad("no result from method invoke.")
        : Result<bool, String>.good(res, "Got result.");
  }
}

/// represents an exception that has occurred because of some native
/// code execution or the lack of.
class NativeException implements Exception {
  final String message;

  const NativeException(this.message);

  @override
  String toString() => "NativeException: $message";
}
