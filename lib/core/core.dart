import 'package:on_the_fly/core/e_files.dart';
import 'package:on_the_fly/core/jobs.dart';
import 'package:on_the_fly/core/output_builder.dart';

export "e_files.dart";
export "jobs.dart";

class AutoImgCore {
  AutoImgCore._();
  static void init() {
    Jobs.registerJob(SingleImgJob());
  }
}

class RoutineOrder<E extends FormatMedium> {
  late final String identifier;
  final String filePath;
  late final E inputType; // if this is null, we autodetect it
  final E outputType;
  final OutputPathHandler outputPathHandler;

  RoutineOrder({
    required this.filePath,
    E? inputType,
    required this.outputType,
    required this.outputPathHandler,
  }) {
    identifier =
        Object.hash(filePath, outputType, outputPathHandler).toString();
    if (inputType == null) {
    } else {
      this.inputType = inputType;
    }
  }
}
