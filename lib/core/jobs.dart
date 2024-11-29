import 'package:on_the_fly/core/output_builder.dart';
import 'package:on_the_fly/core/e_files.dart';
import 'package:on_the_fly/shared/app.dart';

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

class JobInstance<E extends FileFormat> {
  final Jobs<E> parent;

  JobInstance({
    required this.parent,
  });
}

/// a basis for all jobs
///
/// [E] represents the type (usually an enum) that can be used to represent the type of the input/output file types.
abstract class Jobs<E extends FileFormat> {
  final String name;
  final String description;

  /// represents the accepted input types
  final List<E> inputTypes;

  /// represents the output types
  final List<E> outputTypes;
  final String mediumName;

  static Map<String, List<Jobs<FileFormat>>> registeredJobs =
      <String, List<Jobs<FileFormat>>>{};

  static List<Jobs<FileFormat>> getJobsByMedium(String mediumName) {
    if (!registeredJobs.containsKey(mediumName) && kAllowDebugWarnings) {
      throw ArgumentError(
          "Medium Key not found in registered jobs: $mediumName"); // another programmer error ! bruh
    }
    return registeredJobs[mediumName]!;
  }

  static Map<String, Iterable<Jobs<FileFormat>>> get getJobsByMediumMap =>
      registeredJobs;

  static void registerJob(Jobs<FileFormat> r) {
    if (!registeredJobs.containsKey(r.mediumName)) {
      registeredJobs[r.mediumName] = <Jobs<FileFormat>>[];
    }
    registeredJobs[r.mediumName]!.add(r);
    r._id = registeredJobs.length - 1;
  }

  late int _id;

  int get id => _id;

  Jobs({
    required this.name,
    required this.description,
    required this.inputTypes,
    required this.outputTypes,
    required this.mediumName,
  }) {
    assert(inputTypes.isNotEmpty);
    assert(outputTypes.isNotEmpty);
  }
}

class SingleImgJob extends Jobs<FileFormat> {
  SingleImgJob()
      : super(
          name: "Single Image",
          mediumName: ImageMedium.inst.mediumName,
          description:
              "Converts a single image file from one format to another",
          inputTypes: ImageMedium.inst.inputFormats,
          outputTypes: ImageMedium.inst.outputFormats,
        );
}
