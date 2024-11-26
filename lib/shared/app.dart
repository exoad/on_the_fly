import 'dart:math';

import 'package:on_the_fly/core/core.dart';
import 'package:logging/logging.dart';

const String kStrAppName = "On The Fly";
const String kStrVerCode = "0.0.1";
const String kAppGitHubURL = "https://github.com/exoad/on_the_fly";
const bool kRunTests = true;
const bool kAllowDebugWarnings = true;
late final Random random;
final Logger logger = Logger("AutoImg");
Future<void> initConsts() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  AutoImgCore.init();
  random = Random.secure();
}
