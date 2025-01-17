import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/core/components/job_component.dart';
import 'package:on_the_fly/core/formats.dart';
import 'package:on_the_fly/core/formats/images_target.dart';
import 'package:on_the_fly/helpers/basics.dart';
import 'package:on_the_fly/helpers/i18n.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:provider/provider.dart';

export "formats.dart";

class ConversionService {
  @protected
  ConversionService._();

  static late final Map<String, JobAdvert<Job>> adverts;

  static late final List<FormatMedium> mediums;
  static void init() {
    logger.finer("Loading ConversionService utils");
    mediums = <FormatMedium>[ImageMedium.I];
    adverts = <String, JobAdvert<Job>>{
      "net.exoad.jc.single_file": JobAdvert<SingleFileConvertJob>(
        title: LocaleProducer.key("job style adverts.single_file_title"),
        description: LocaleProducer.key("job style adverts.single_file_description"),
        supportedMediums: mediums,
        producer: (BuildContext context) => SingleFileConvertJob(),
      ),
      // "net.exoad.jc.multiple_files": JobAdvert<Job>(
      //   title: LocaleProducer.key("job style adverts.multiple_files_title"),
      //   description: LocaleProducer.key("job style adverts.multiple_files_description"),
      //   supportedMediums: mediums,
      // ),
      // "net.exoad.jc.watch_folder": JobAdvert<Job>(
      //     title: LocaleProducer.key("job style adverts.watch_folder_title"),
      //     description: LocaleProducer.key("job style adverts.watch_folder_description"),
      //     supportedMediums: mediums),
    };
    logger.finer("Done loading ConversionService utils\n$adverts\n$mediums");
  }
}

class JobAdvert<E extends Job> {
  final LocaleProducer title;
  final LocaleProducer description;
  final List<FormatMedium> supportedMediums;
  final E Function(BuildContext context) producer;

  const JobAdvert(
      {required this.title,
      required this.description,
      required this.supportedMediums,
      required this.producer});

  @override
  String toString() => "${title.value}:${description.value}:$supportedMediums";
}

class TransmuteService {
  @protected
  TransmuteService._();

  static late final Map<String, JobAdvert<Job>> adverts;

  static late final List<FormatMedium> mediums;
  static void init() {}
}

/// the different types of jobs accepted, this is used to help with attaching the
/// job to specific isolates
enum JobType {
  /// a single file
  SINGLE,

  /// multiple files (this is done on an isolate)
  MULTI,

  /// watch a folder (this is done on an isolate)
  WATCH
}

abstract class Job {
  static const String kJobInputLocationKey = "input_location";
  final String identifier;
  late int _creationTime;

  /// should be a hashed identifier unique to this job instance and across all
  /// job instances, no matter if they are transmuters or convertors
  late int _hash;

  int get hash => _hash;

  int get creationTime => _creationTime;

  JobType get jobType;

  String get displayTitle;

  /// called when the "start" button is clicked by the user
  void attach();

  bool get isTransmute => this is TransmuteJob;

  bool get isConvert => this is ConvertJob;

  Job(this.identifier, [int? creationTime]) {
    _creationTime = creationTime ?? DateTime.now().millisecondsSinceEpoch;
    _hash = Object.hash(identifier, this);
  }

  JobBody buildForm(BuildContext context);
}

abstract class ConvertJob extends Job {
  ConvertJob(super.identifier) {
    if (kAllowDebugWarnings && !ConversionService.adverts.containsKey(super.identifier)) {
      logger.warning(
          "The provided key for ${super.identifier} on $_hash could not be found in the adverts registry!"); // programmer error
    }
  }

  @override
  String get displayTitle => ConversionService.adverts[super.identifier]!.title.value;
}

class SingleFileConvertJob extends ConvertJob {
  SingleFileConvertJob() : super("net.exoad.jc.single_file") {}
  @override
  JobType get jobType => JobType.SINGLE;

  @override
  void attach() {}

  @override
  JobBody buildForm(BuildContext context) {
    return JobBody(onRemoveJob: IGNORE_INVOKE, children: <Widget>[
      JobSinglePathPickerActionable(
          JobState.kInputFileEpKey,
          supported: ConversionService.mediums,
          onChanged: (String file) {},
          filePickerLabel: Provider.of<InternationalizationNotifier>(context)
              .i18n
              .formatGeneric
              .input_file_path,
          allowedExtensions: ConversionService.mediums.allExtension)
    ]);
  }
}

abstract class TransmuteJob implements Job {}

class JobStack with ChangeNotifier {
  final SplayTreeSet<Job> _stack;

  JobStack()
      : _stack = SplayTreeSet<Job>(
            (Job a, Job b) => a._creationTime.compareTo(b.creationTime));

  bool isEmpty() => _stack.isEmpty;

  int get length => _stack.length;

  void push(String identifier, Job instance) {
    _stack.add(instance);
    notifyListeners();
  }

  Job at(int index) => _stack.elementAt(index);

  void pop(Job instance) {
    if (containsJob(instance)) {
      _stack.remove(instance);
    }
    notifyListeners();
  }

  void popAll(String identifier) {
    if (containsIdentifier(identifier)) {
      _stack.clear();
    }
    notifyListeners();
  }

  bool containsIdentifier(String identifier) =>
      _stack.any((Job job) => job.identifier == identifier);

  bool containsJob(Job instance) => _stack.contains(instance);
}
