import 'package:flutter/services.dart';
import 'package:on_the_fly/base/native_channel.dart';
import 'package:on_the_fly/shared/app.dart';

final class WinMan {
  static final WinMan I = WinMan._();

  static const String _kFocusKey = "focus";
  static const String _kSetTitleKey = "set_title";

  final MethodChannel _mNative;

  WinMan._() : _mNative = const MethodChannel("net.exoad.on_the_fly/win_man");

  Future<void> requestFocus() async {
    (await BasicNativeChannel.safeInvoke(_mNative, _kFocusKey))
        .onBad((String message) => logger.warning("WINMAN_FAIL_INVOKE: $message"));
  }

  Future<void> setTitle(String title) async {
    try {
      await _mNative.invokeMapMethod(_kSetTitleKey, <String, String>{"title": title});
    } on PlatformException catch (e) {
      logger.severe(e.message);
    }
  }
}
