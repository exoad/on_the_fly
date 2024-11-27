import 'package:on_the_fly/core/convert_job.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/e_focus.dart';
import 'package:on_the_fly/core/utils/form_ui_transfer.dart';

class JobInstance {
  final Jobs parent;
  final String inputPath;
  final OutputPathHandler outputPathHandler;
  final ImgFileTypes outputType;

  const JobInstance({
    required this.parent,
    required this.inputPath,
    required this.outputPathHandler,
    required this.outputType,
  });
}

abstract class Jobs {
  final String name;
  final String description;
  final List<ImgFileTypes> inputTypes;
  final List<ImgFileTypes> outputTypes;
  final JobFocusMedium medium;

  static Map<int, Jobs> registeredJobs = <int, Jobs>{};

  static Iterable<Jobs> getJobsByMedium(JobFocusMedium medium) {
    return registeredJobs.values
        .where((Jobs element) => element.medium == medium);
  }

  static Map<JobFocusMedium, Iterable<Jobs>> get getJobsByMediumMap {
    Map<JobFocusMedium, Iterable<Jobs>> map =
        <JobFocusMedium, Iterable<Jobs>>{};
    for (JobFocusMedium medium in JobFocusMedium.values) {
      map[medium] = getJobsByMedium(medium);
    }
    return map;
  }

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

  List<UIPump<dynamic>> launchUIForm() {
    return <UIPump<dynamic>>[

    ];
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

  @override
  E createInstance<E extends JobInstance>(
      {required String inputPath,
      required OutputPathHandler outputPathHandler,
      required ImgFileTypes outputType}) {
    return JobInstance(
      parent: this,
      inputPath: inputPath,
      outputPathHandler: outputPathHandler,
      outputType: outputType,
    ) as E;
  }
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

  @override
  E createInstance<E extends JobInstance>(
      {required String inputPath,
      required OutputPathHandler outputPathHandler,
      required ImgFileTypes outputType}) {
    return JobInstance(
      parent: this,
      inputPath: inputPath,
      outputPathHandler: outputPathHandler,
      outputType: outputType,
    ) as E;
  }
}
