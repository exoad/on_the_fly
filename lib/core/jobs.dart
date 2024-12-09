import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_to_form/json_schema.dart';
import 'package:meta/meta.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/form_ui_transfer.dart';
import 'package:on_the_fly/core/utils/result.dart';
import 'package:on_the_fly/shared/app.dart';

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

  final OrderForm _orderForm;

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

  @nonVirtual
  OrderForm get orderForm => _orderForm;

  JobDispatcher(
      {required this.name,
      required this.description,
      required this.inputTypes,
      required this.outputTypes,
      required this.mediumName,
      required OrderForm orderForm})
      : _orderForm = orderForm {
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

  @nonVirtual
  @protected
  Future<void> launchForm(BuildContext context, void Function(dynamic val) onSave) async =>
      await Navigator.of(context).push(MaterialPageRoute<Widget>(
          builder: (BuildContext context) => Scaffold(
                appBar: AppBar(title: Text("Create job instance of $name")),
                body: JsonSchema(
                    onChanged: jsonFormOnChanged, actionSave: onSave,form: jsonEncode(jsonForm)),
              )));

  Future<void> buildJob(BuildContext context) async {
    await launchForm(context,jsonFormOnSave);
  }
}
