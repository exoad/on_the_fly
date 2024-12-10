import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ionicons/ionicons.dart';
import 'package:json_to_form/json_schema.dart';
import 'package:meta/meta.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/result.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';

/// an instance created by a job dispatcher which represents a user
/// specified action to run
///
abstract class Job {
  List<String> inputPath;
  OutputNameBuilder outputNameBuilder;

  Job({required this.inputPath, required this.outputNameBuilder});

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
}

/// a basis for all jobs
///
/// [E] represents the type (usually an enum) that can be used to represent the type of the input/output file types.
abstract class JobDispatcher {
  final String name;
  final String description;

  /// represents the accepted input types
  final List<FileFormat> inputTypes;

  /// represents the output types
  final List<FileFormat> outputTypes;
  final String mediumName;

  static Map<String, List<JobDispatcher>> registeredJobDispatchers =
      <String, List<JobDispatcher>>{};

  static List<JobDispatcher> getJobDispatchersByMedium(String mediumName) {
    if (!registeredJobDispatchers.containsKey(mediumName) &&
        kAllowDebugWarnings) {
      throw ArgumentError(
          "Medium Key not found in registered jobs: $mediumName"); // another programmer error ! bruh
    }
    return registeredJobDispatchers[mediumName]!;
  }

  static Map<String, Iterable<JobDispatcher>> get getJobsByMediumMap =>
      registeredJobDispatchers;

  static void registerJobDispatcher(JobDispatcher r) {
    if (!registeredJobDispatchers.containsKey(r.mediumName)) {
      registeredJobDispatchers[r.mediumName] = <JobDispatcher>[];
    }
    registeredJobDispatchers[r.mediumName]!.add(r);
    r._id = registeredJobDispatchers.length - 1;
  }

  late int _id;

  int get id => _id;

  JobDispatcher(
      {required this.name,
      required this.description,
      required this.inputTypes,
      required this.outputTypes,
      required this.mediumName}) {
    assert(inputTypes.isNotEmpty);
    assert(outputTypes.isNotEmpty);
  }

  Map<String, dynamic> get jsonForm;

  @mustBeOverridden
  Map<String, dynamic> get jsonFormValidators => <String, dynamic>{};

  @mustBeOverridden
  Map<String, dynamic> get jsonFormDecorations => <String, dynamic>{};

  void jsonFormOnChanged(dynamic res) {}

  @mustBeOverridden
  void jsonFormOnSave(dynamic res) {}

  List<Widget> get otherFormWidgets => const <Widget>[];

  @nonVirtual
  @protected
  Future<void> launchForm(
      BuildContext context, void Function(dynamic val) onSave) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(kJobDispatcherFormScaffoldMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Create job instance of $name",
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: kStylizedFontFamily,
                      fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: <Widget>[
                  ...otherFormWidgets,
                  JsonSchema(
                    onChanged: jsonFormOnChanged,
                    actionSave: onSave,
                    decorations: jsonFormDecorations,
                    validations: jsonFormValidators,
                    formMap: jsonForm,
                  ),
                ]),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {
                      // todo implement what happens after
                      Navigator.of(context).pop();
                    },
                    child: const Text("Schedule Job"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> buildJob(BuildContext context) async {
    await launchForm(context, jsonFormOnSave);
  }
}

class JobDispatcherFormBuilder {
  JobDispatcherFormBuilder._();

  static Map<String, dynamic> fSingleInputPath(String key,
          [String additionalHelperText = ""]) =>
      <String, dynamic>{
        "key": key,
        "type": "Input",
        "required": true,
        "label": "Path to input file",
        "decoration": InputDecoration(
            helper: Text(
                "$additionalHelperText Example: .\\Downloads\\Cat_Picture.png",
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: kStylizedFontFamily,
                    color: kThemePrimaryFg2)),
            suffix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: FilledButton(
                      onPressed: () async {
                        await FilePicker.platform
                            .pickFiles(dialogTitle: "Pick file");
                      }, // todo: incorporate with native file picker and fully implement this
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRRArc))),
                          backgroundColor:
                              const WidgetStatePropertyAll<Color>(kTheme1),
                          foregroundColor:
                              const WidgetStatePropertyAll<Color>(kThemeBg),
                          visualDensity: VisualDensity.compact),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Ionicons.folder_outline,
                            size: 24,
                          ),
                          SizedBox(width: 4),
                          Text("Use file picker",
                              style: TextStyle(fontSize: 12))
                        ],
                      ))
                  .animate()
                  .fade(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeInOut),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(kRRArc))))
      };
}
