import 'package:on_the_fly/core/e_files.dart';
import 'package:on_the_fly/core/formats/formats.dart';
import 'package:on_the_fly/core/jobs.dart';
import 'package:on_the_fly/core/output_builder.dart';
import 'package:on_the_fly/core/utils/result.dart';

export "e_files.dart";
export "jobs.dart";
export "output_builder.dart";
export "folder_watchdog.dart";

class AutoImgCore {
  AutoImgCore._();
  static void init() {
    JobDispatcher.registerJobDispatcher(SingleImgJobDispatcher());
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

/// this is the main conversion manager where it dispatches
/// routine orders to the correct routine processor that matches that format
class RoutineParticipant {
  final int hash;
  static final Map<dynamic, RoutineProcessor<dynamic>> _processorsRegistry =
      <dynamic, RoutineProcessor<dynamic>>{};

  static void loadProcessors() {}

  RoutineParticipant(this.hash);
}

abstract class RoutineProcessor<E extends FormatMedium> {
  late int hash;

  Future<Result<Null, String>> convert(RoutineOrder<E> order);
}
