// import 'dart:collection';
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:on_the_fly/client/logging_view.dart';
import 'package:logging/logging.dart';

const String kStrAppName = "On The Fly";
const String kStrVerCode = "0.0.1";
const String kAppGitHubURL = "https://github.com/exoad/on_the_fly";

/// runs the tests found in the main() of the app
/// for release, this should be false
const bool kRunTests = true;

/// if a test does not run with a correct/expected behavior,
/// the program will panic and then exit
const bool kFailedTestsPanic = true;

/// still reports the results of tests that has passed
///
/// failed tests will either way still show
const bool kShowSuccessfulTestResults = true;

/// used in development to run [SandboxView] instead of the main app [AppView]
///
/// this is off for release versions, but during dev this is
/// for seeing how certain visual elements will look
const bool kRunSandboxView = true;

/// an immediate mode ui is ran on top of the app that shows important information
///
/// (good for debug)
const bool kShowDebugView = false;

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

/// hardcoded locale definitions pool
const List<String> kDefinedLocales = <String>[
  "en", // english - default;unknown
  "zh" // simplified chinese
];

late final Random random;
late Map<String, String> localeMap;
final Logger logger = Logger("OnTheFly");

/// initialize the constants and some other core elements of the app
/// such as logging as well as the internal registry of the app so
/// it knows all the registered jobs
Future<void> initConsts() async {
  logger.onRecord.listen((LogRecord record) {
    final String built = "[${record.level.name}]: ${record.time}: ${record.message}";
    print(built);
    pushbackLogRecord(record);
  });
  hierarchicalLoggingEnabled = true;
  logger.level = Level.ALL;
  random = Random.secure();
}

/// a very lightweight helper for showing up warnings and other
/// related utility functions for the developer when making the app
class AppDebug {
  AppDebug._();

  static final AppDebug _singleton = AppDebug._();

  factory AppDebug() => _singleton;

  late int _startUpTimestamp = -1;

  /// registers the startup time (very important !!! not really LOL)
  set startUpTimestamp(int time) {
    if (_startUpTimestamp < 0) {
      _startUpTimestamp = time;
    } else {
      logger.warning(
          "Start Up Timestamp has already been registered to ${DateTime.fromMicrosecondsSinceEpoch(_startUpTimestamp)}. No change.");
    }
  }

  /// the startup time of the app
  int get startUpTimestamp => _startUpTimestamp;

  /// the most basic test function possible LOL, im sorry, not gonna
  /// use a testing framework for this, not necessary imo (yuh)
  void test<E>(String testName, E Function() ax, E? expected) {
    E res = ax();
    logger.info(// oh YEA WE LOVE INTERPOLATION WITHIN INTERPOLATION
        "${expected == null || res == expected ? "[OK] ${kShowSuccessfulTestResults ? "'$res'" : ""}" : "[XX] got '$res', expected '$expected' "} - $testName ");
    if (res != expected && expected != null && kFailedTestsPanic) {
      // panic due to failed test
      logger.info("Program exited due to failed test: $testName");
      exit(-1);
    }
  }
}
