import 'package:on_the_fly/core/jobs.dart';

export "e_files.dart";
export "jobs.dart";

class AutoImgCore {
  AutoImgCore._();
  static void init() {
    Jobs.registerJob(SingleImgJob());
  }
}
