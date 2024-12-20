import 'package:flutter/material.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/result.dart';
import 'package:on_the_fly/frontend/events/ephemeral_stacks.dart';

final class ImageMedium extends FormatMedium {
  static final ImageMedium inst = ImageMedium();

  @protected
  ImageMedium()
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
              "tif": const FileFormat(
                  canonicalName: "TIFF",
                  validExtensions: <String>["tiff"],
                  canWrite: true,
                  canRead: true),
            });
}

/// this represents a single convert job for a single image file
class SingleImgJobDispatcher extends JobDispatcher {
  SingleImgJobDispatcher()
      : super(
          inputTypes: ImageMedium.inst.inputFormats,
          outputTypes: ImageMedium.inst.outputFormats,
        );

  @override
  bool dispatched(covariant dynamic t) {
    return t.runtimeType == SingleImgJob;
  }

  @override
  String get description => InternationalizationNotifier().i18n.singleImgJob.description;

  @override
  FormatMedium get formatMedium => ImageMedium.inst;

  @override
  String get name => InternationalizationNotifier().i18n.singleImgJob.canonical_name;

  @override
  String? get properDescription =>
      InternationalizationNotifier().i18n.singleImgJob.proper_description;
}

class SingleImgJob extends Job {
  SingleImgJob({required super.inputPath, required super.outputNameBuilder});

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
}

class ImageRoutineProcessor extends RoutineProcessor<ImageMedium> {
  @override
  Future<Result<Null, String>> convert(RoutineOrder<ImageMedium> order) async {
    throw UnimplementedError();
  }

  @override
  String get canonicalName => "Builtin Image Processor";

  @override
  String get canonicalDescriptor =>
      "Used for processing image files such as PNG, JPEG, etc.. This processor is builtin to OnTheFly";
}
