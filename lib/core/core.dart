import 'package:on_the_fly/core/jobs.dart';

export "convert_job.dart";
export "e_files.dart";
export "jobs.dart";

class AutoImgCore {
  AutoImgCore._();

  static void init() {
    Jobs.registerJob(SingleFileJob());
    Jobs.registerJob(MultiFileJob());
  }
}
