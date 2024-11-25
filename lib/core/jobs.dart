import 'package:auto_img/core/core.dart';

class Jobs {
  final String name;
  final String description;
  final List<ImgFileTypes> inputTypes;
  final List<ImgFileTypes> outputTypes;

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
  }) {
    assert(inputTypes.isNotEmpty);
    assert(outputTypes.isNotEmpty);
  }
}

class SingleFileJob extends Jobs {
  SingleFileJob()
      : super(
          name: "Single File",
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
          description:
              "Converts multiple files from one format to another",
          inputTypes: ImgFileTypes.inputTypes,
          outputTypes: ImgFileTypes.outputTypes,
        );
}