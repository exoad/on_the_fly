import 'dart:math';

const String kStrVerCode = "0.0.1";
const String kAppGitHubURL = "https://github.com/exoad/auto_img";
late final Random random;
Future<void> initConsts() async {
  random = Random.secure();
}
