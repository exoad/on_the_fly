import 'package:on_the_fly/base/native_channel.dart';
import 'package:on_the_fly/shared/app.dart';

/// Performs the C0 (Complexity-0) check to make sure the platform
/// for the current device is up and running.
Future<bool> sanityCheck() async {
  return (await BasicNativeChannel.safeInvokeBool(mNativeChannel1, "DoesExist")).isGood;
}

class AppEphemeral {
  AppEphemeral._();

  static Future<void> focusWindow() async {}
}
