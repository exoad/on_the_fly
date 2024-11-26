import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/e_focus.dart';

class Jobs {
  final String name;
  final String description;
  final List<ImgFileTypes> inputTypes;
  final List<ImgFileTypes> outputTypes;
  final JobFocusMedium medium;

  static Map<int, Jobs> registeredJobs = <int, Jobs>{};

  static void registerJob<E extends Jobs>(E r) {
    registeredJobs[registeredJobs.length] = r;
    r.id = registeredJobs.length - 1;
  }

  late int id;

  Jobs({
    required this.name,
    required this.description,
    required this.inputTypes,
    required this.outputTypes,
    required this.medium,
  }) {
    assert(inputTypes.isNotEmpty);
    assert(outputTypes.isNotEmpty);
  }
}

class SingleFileJob extends Jobs {
  SingleFileJob()
      : super(
          name: "Single File",
          medium: JobFocusMedium.image,
          description:
              "Converts a single file from one format to another",
          inputTypes: ImgFileTypes.inputTypes,
          outputTypes: ImgFileTypes.outputTypes,
        );
}

class MultiFileJob extends Jobs {
  MultiFileJob()
      : super(
          name: "Multi File",
          medium: JobFocusMedium.image,
          description:
              "Converts multiple files from one format to another",
          inputTypes: ImgFileTypes.inputTypes,
          outputTypes: ImgFileTypes.outputTypes,
        );
}
