import 'package:on_the_fly/base/native_channel.dart';
import 'package:on_the_fly/shared/app.dart';

class AppEphemeral {
  AppEphemeral._();

  /// Performs the C0 (Complexity-0) check to make sure the platform
  /// for the current device is up and running.
  static Future<bool> sanityCheck() async {
    return (await BasicNativeChannel.safeInvokeBool(
            mNativeChannel1, "DoesExist"))
        .isGood;
  }
}
