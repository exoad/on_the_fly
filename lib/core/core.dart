import 'package:auto_img/core/convert_job.dart';

export "convert_job.dart";
export "e_files.dart";
export "builtin_pb_jobs.dart";

class AutoImgCore {
  AutoImgCore._();

  late List<ConvertJob> registeredJobs;

  void init() {
    registeredJobs = <ConvertJob>[];
  }
}
