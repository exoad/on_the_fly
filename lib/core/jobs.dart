import 'package:on_the_fly/core/builtin/media_img.dart';
import 'package:on_the_fly/core/convert_job.dart';
import 'package:on_the_fly/core/e_focus.dart';
import 'package:on_the_fly/core/utils/form_ui_transfer.dart';

class RoutineOrder {
  late final String identifier;
  final String filePath;
  late final ImgFileTypes inputType; // if this is null, we autodetect it
  final ImgFileTypes outputType;
  final OutputPathHandler outputPathHandler;

  RoutineOrder({
    required this.filePath,
    ImgFileTypes? inputType,
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

class JobInstance {
  final Jobs parent;
  final UIForm form;

  const JobInstance({
    required this.parent,
    required this.form,
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

  JobInstance get basis;
}

class SingleFileJob extends Jobs {
  SingleFileJob()
      : super(
          name: "Single File",
          medium: JobFocusMedium.image,
          description: "Converts a single file from one format to another",
          inputTypes: ImgFileTypes.inputTypes,
          outputTypes: ImgFileTypes.outputTypes,
        );

  @override
  JobInstance get basis => JobInstance(
        parent: this,
        form: UIForm(
          title: "Single File Conversion",
          pumps: <String, UIPump<dynamic>>{
            "Input File": StringInputPump(
              label: "Input File",
              pump: (String input) {},
            ),
            "Output File": StringInputPump(
              label: "Output File",
              pump: (String input) {},
            ),
            "Input Type": StringInputPump(
              label: "Input Type",
              pump: (String input) {},
            ),
            "Output Type": StringInputPump(
              label: "Output Type",
              pump: (String input) {},
            ),
          },
        ),
      );
}
