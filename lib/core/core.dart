import 'package:flutter/material.dart';
import 'package:on_the_fly/core/e_files.dart';
import 'package:on_the_fly/core/formats/formats.dart';
import 'package:on_the_fly/core/jobs.dart';
import 'package:on_the_fly/core/output_builder.dart';
import 'package:on_the_fly/core/utils/result.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:path/path.dart';

export "e_files.dart";
export "jobs.dart";
export "output_builder.dart";
export "folder_watchdog.dart";

class AutoImgCore {
  AutoImgCore._();
  static void init() {
    JobDispatcher.registerJobDispatcher(SingleImgJobDispatcher());
    RoutineParticipant.loadProcessors();
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
  static final Map<Type, RoutineProcessor<FormatMedium>> _processorsRegistry =
      <Type, RoutineProcessor<FormatMedium>>{};

  static void loadProcessors() {
    _processorsRegistry[ImageMedium] = ImageRoutineProcessor();
    logger.info("Loaded ${_processorsRegistry.length} processors:");
    int i = 1;
    for (MapEntry<Type, RoutineProcessor<FormatMedium>> entry
        in _processorsRegistry.entries) {
      logger.info("\t${i++}) ${entry.key}=${entry.value}");
    }
  }

  RoutineParticipant(this.hash);
}

abstract class RoutineProcessor<E extends FormatMedium> {
  covariant late int hash;

  @protected
  RoutineProcessor() {
    hash = Object.hash(canonicalName, canonicalDescriptor);
  }

  String get canonicalName;

  String get canonicalDescriptor;

  /// the definition of the result type simply relies on the isGood and isBad methods
  /// within the result instance itself. the string will still hold a permanent value
  /// of what happened
  Future<Result<Null, String>> convert(RoutineOrder<E> order);

  @override
  String toString() => "$canonicalName[$hash] -> $canonicalDescriptor";
}
