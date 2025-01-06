import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/core/components/j_prebuilt.dart';
import 'package:on_the_fly/core/components/j_spinner.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/date_time.dart';
import 'package:on_the_fly/core/utils/result.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';

import 'package:on_the_fly/core/components/job_component.dart' as j;
import 'package:on_the_fly/client/events/job_stack.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

/// represents the builtin image formats supported by on the fly
///
/// see [FormatMedium] for more indepth information
final class ImageMedium extends FormatMedium {
  static final ImageMedium instance = ImageMedium._();

  @protected
  ImageMedium._()
      : super(
            mediumName: InternationalizationNotifier().i18n.formatGeneric.image,
            formats: <String, FileFormat>{
              "webp": const FileFormat(
                  canonicalName: "WebP",
                  validExtensions: <String>["webp"],
                  canWrite: false,
                  canRead: true),
              "jpg": const FileFormat(
                  canonicalName: "JPEG",
                  validExtensions: <String>["jpg", "jpeg"],
                  canWrite: true,
                  canRead: true),
              "bmp": const FileFormat(
                  canonicalName: "BMP",
                  validExtensions: <String>["bmp"],
                  canWrite: true,
                  canRead: true),
              "ico": const FileFormat(
                  canonicalName: "ICO",
                  validExtensions: <String>["ico"],
                  canWrite: true,
                  canRead: true),
              "png": const FileFormat(
                  canonicalName: "PNG",
                  validExtensions: <String>["png"],
                  canWrite: true,
                  canRead: true),
              "gif": const FileFormat(
                  canonicalName: "GIF",
                  validExtensions: <String>["gif"],
                  canWrite: true,
                  canRead: true),
              "tiff": const FileFormat(
                  canonicalName: "TIFF",
                  validExtensions: <String>["tiff"],
                  canWrite: true,
                  canRead: true),
              "tga": const FileFormat(
                  canonicalName: "TGA",
                  validExtensions: <String>["tga", "icb"],
                  canWrite: true,
                  canRead: true),
              "psd": const FileFormat(
                  canonicalName: "PSD",
                  validExtensions: <String>["psd"],
                  canWrite: false,
                  canRead: true),
            });
}

/// this represents a dispatcher that produces a [SingleImgJob] instance on demand. it also
/// facilitates defining the general structure of singleimg jobs
class SingleImgJobDispatcher extends JobDispatcher {
  SingleImgJobDispatcher() : super(formatMedium: ImageMedium.instance);

  @override
  bool dispatched(covariant dynamic t) {
    return t.runtimeType == SingleImgJob;
  }

  @override
  String get description => InternationalizationNotifier().i18n.singleImgJob.description;

  @override
  String get name => InternationalizationNotifier().i18n.singleImgJob.canonical_name;

  @override
  String? get properDescription =>
      InternationalizationNotifier().i18n.singleImgJob.proper_description;

  @override
  Type get routineProcessor => ImageRoutineProcessor;

  @override
  Job produceInitialJobInstance() {
    return SingleImgJob(inputPath: <String>[Platform.resolvedExecutable]);
  }
}

/// a job instance produced by the [SingleImgJobDispatcher] dispatcher
class SingleImgJob extends Job {
  late OutputPathHandler outputPathHandler;

  SingleImgJob({required super.inputPath});

  @override
  OutputPathHandler get outputNameBuilder => outputPathHandler;

  @override
  bool canPop() {
    return true;
  }

  @override
  void onPush() {}

  @override
  Result<Null, String> process() {
    throw UnimplementedError();
  }

  @override
  j.JobBody buildForm(BuildContext context) {
    return j.JobBody(
        onRemoveJob: () =>
            Provider.of<GlobalJobStack>(context, listen: false).removeJob(this),
        children: <Widget>[
          j.JobTitle(
            title: Provider.of<InternationalizationNotifier>(context)
                .i18n
                .singleImgJob
                .canonical_name,
            subtitle: timestamp.canonicalizedTimeString,
          ),
          const SizedBox(height: 12),
          j.JobSinglePathPickerActionable(
              validator: FilePathValidators.validateFilePath,
              onChanged: (String str) {},
              allowedExtensions: List<String>.empty(),
              canonicalLabel: "Input file path",
              filePickerLabel:
                  Provider.of<InternationalizationNotifier>(context, listen: false)
                      .i18n
                      .appGenerics
                      .browse),
          const SizedBox(height: 6),
          j.JobSimpleSpinner<FileFormat>(
              chips: j.SpinnerChip.fromRelated(
                  ImageMedium.instance.outputFormats
                      .map((FileFormat format) => (format.canonicalName, format)),
                  const Icon(Ionicons.document, color: kTheme2)),
              onSelect: (e) {},
              title: "Helo",
              subtitle: "Amogus")
        ]);
  }
}

class ImageRoutineProcessor extends RoutineProcessor<ImageMedium> {
  @override
  Future<Result<Null, String>> convert(RoutineOrder<ImageMedium> order) async {
    throw UnimplementedError();
  }

  @override
  String get canonicalName =>
      InternationalizationNotifier().i18n.builtinImgProcessor.canonical_name;

  @override
  String get canonicalDescriptor =>
      InternationalizationNotifier().i18n.builtinImgProcessor.proper_description;
}
