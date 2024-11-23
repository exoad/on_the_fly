import 'dart:math';

const String kStrVerCode = "0.0.1";
late final Random random;
Future<void> initConsts() async {
  random = Random.secure();
}
