import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:meta/meta.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/result.dart';
import 'package:on_the_fly/frontend/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

/// an instance created by a job dispatcher which represents a user
/// specified action to run
///
abstract class Job {
  List<String> inputPath;

  Job({required this.inputPath});

  /// processes and generates an output name
  OutputPathHandler get outputNameBuilder;

  /// called when this job instance gets pushed onto the global job stack
  ///
  /// should not any kind of processing work as this fucks up the scheduler
  void onPush();

  /// called by the global job stack to determine if this job can be popped
  ///
  /// it usually is `true`, but for example, this action may be blocked for when
  /// it requires a task to run without exiting abnormally
  bool canPop();

  /// called for when this job stack has determined this job is suitable to be ran
  ///
  /// returns a result which represents the job status
  Result<Null, String> process();

  @mustBeOverridden
  Widget buildForm(BuildContext context) {
    // this is a debug no impl error that is shown to alert developers that this part of the code is unfinished
    //
    // so pls reimpl this (also dont call super if you do)
    return Container(
        decoration:
            BoxDecoration(color: kTheme1, borderRadius: BorderRadius.circular(kRRArc)),
        padding: const EdgeInsets.all(8),
        child: Center(
            child: Text.rich(TextSpan(
                text:
                    ">>> ${Provider.of<InternationalizationNotifier>(context).i18n.appGenerics.no_impl} <<<\n",
                children: <InlineSpan>[
              const WidgetSpan(child: Icon(Ionicons.code_slash)),
              TextSpan(
                  text: "\t$runtimeType#$hashCode",
                  style: const TextStyle(fontWeight: FontWeight.normal))
            ]))));
  }
}

/// a basis for all jobs
///
/// [E] represents the type (usually an enum) that can be used to represent the type of the input/output file types.
abstract class JobDispatcher {
  /// represents the accepted input types
  final List<FileFormat> inputTypes;

  /// represents the output types
  final List<FileFormat> outputTypes;

  static Map<String, List<JobDispatcher>> registeredJobDispatchers =
      <String, List<JobDispatcher>>{};

  static List<JobDispatcher> getJobDispatchersByMedium(String mediumName) {
    if (!registeredJobDispatchers.containsKey(mediumName) && kAllowDebugWarnings) {
      throw ArgumentError(
          "Medium Key not found in registered jobs: $mediumName"); // another programmer error ! bruh
    }
    return registeredJobDispatchers[mediumName]!;
  }

  static Map<String, Iterable<JobDispatcher>> get getJobsByMediumMap =>
      registeredJobDispatchers;

  static void registerJobDispatcher(JobDispatcher r) {
    if (!registeredJobDispatchers.containsKey(r.formatMedium.mediumName)) {
      registeredJobDispatchers[r.formatMedium.mediumName] = <JobDispatcher>[];
    }
    registeredJobDispatchers[r.formatMedium.mediumName]!.add(r);
    r._id = registeredJobDispatchers.length - 1;
  }

  late int _id;

  int get id => _id;

  JobDispatcher({required this.inputTypes, required this.outputTypes}) {
    assert(inputTypes.isNotEmpty);
    assert(outputTypes.isNotEmpty);
  }

  /// checks if a given var's runtimeType is of the dispatching (related)
  /// type. the general implementation should be the same throughout all
  /// mediums and formats
  bool dispatched(dynamic t);

  /// canonical
  String get name;

  /// canonical
  String get description;

  FormatMedium get formatMedium;

  // putting this on the burner for now (not impl/used)
  // /// canonical. shown when the user clicks to view more about this job
  // /// dispatcher. by default, the normal [name] and [description] will still be
  // /// shown. this method is used to add additional content
  // Widget? get additionalDescriptors => null;

  /// an indepth canonical description used by the job dispatcher viewer (the thing that pops up when you click on a job dispatcher on the left menu view)
  /// its best to often implement and provide description for this method instead of returning either [description]
  /// or `null`
  String? get properDescription;

  Type get routineProcessor;

  /// this function produces an initial instance of this job that MUST be remodified by
  /// the user.
  Job produceInitialJobInstance();
}

// class JobDispatcherFormBuilder {
//   JobDispatcherFormBuilder._();

//   static Map<String, dynamic> fSingleInputPath(String key,
//           [String additionalHelperText = ""]) =>
//       <String, dynamic>{
//         "key": key,
//         "type": "Input",
//         "required": true,
//         "label": "Path to input file",
//         "decoration": InputDecoration(
//             helper: Text("$additionalHelperText Example: .\\Downloads\\Cat_Picture.png",
//                 style: const TextStyle(fontSize: 14, color: kThemePrimaryFg2)),
//             suffix: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//               child: FilledButton(
//                       onPressed: () async {
//                         await FilePicker.platform.pickFiles(dialogTitle: "Pick file");
//                       }, // todo: incorporate with native file picker and fully implement this
//                       style: ButtonStyle(
//                           shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(kRRArc))),
//                           backgroundColor: const WidgetStatePropertyAll<Color>(kTheme1),
//                           foregroundColor: const WidgetStatePropertyAll<Color>(kThemeBg),
//                           visualDensity: VisualDensity.compact),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Icon(
//                             Ionicons.folder_outline,
//                             size: 24,
//                           ),
//                           SizedBox(width: 4),
//                           Text("Use file picker", style: TextStyle(fontSize: 12))
//                         ],
//                       ))
//                   .animate()
//                   .fade(
//                       duration: const Duration(milliseconds: 220),
//                       curve: Curves.easeInOut),
//             ),
//             border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(kRRArc))))
//       };
// }
