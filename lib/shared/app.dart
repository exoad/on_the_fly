import 'dart:math';

import 'package:flutter/services.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:logging/logging.dart';

const String kStrAppName = "On The Fly";
const String kStrVerCode = "0.0.1";
const String kAppGitHubURL = "https://github.com/exoad/on_the_fly";

/// runs the tests found in the main() of the app
/// for release, this should be false
const bool kRunTests = true;

/// used in development to run [SandboxView] instead of the main app [AppView]
///
/// this is off for release versions, but during dev this is
/// for seeing how certain visual elements will look
const bool kRunSandboxView = true;

/// determines whether certain things where type checking or sanity
/// checks are done should be done or not
///
/// a common case is for overriding the [] operator for a class
/// where instead of returning a nullable type, it returns a
/// non-nullable type ensuring that the value is always present
/// and ensures that if there is an error, it 99.8% of the time
/// caused by the bum ass programmer supplying an invalid value
/// (typo, careless mistake)
const bool kAllowDebugWarnings = true;

/// whether informational log messages are logged
///
/// can be on or off no matter the production state
const bool kAllowDebugLogs = true;
late final Random random;
final Logger logger = Logger("AutoImg");

/// this platform channel basically just checks if the platform
/// channel is working properly in the hollistic sense
const MethodChannel mSanityCheck = MethodChannel("net.exoad.on_the_fly/sanity_check");

/// initialize the constants and some other core elements of the app
/// such as logging as well as the internal registry of the app so
/// it knows all the registered jobs
Future<void> initConsts() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  AutoImgCore.init();
  random = Random.secure();
}
