import 'package:flutter/material.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/result.dart';
import 'package:on_the_fly/shared/theme.dart';

final class ImageMedium extends FormatMedium {
  static final ImageMedium inst = ImageMedium();

  @protected
  ImageMedium()
      : super(mediumName: "Image", formats: <String, FileFormat>{
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
          name: "Single Image",
          mediumName: ImageMedium.inst.mediumName,
          description:
              "Converts a single image file from one format to another",
          inputTypes: ImageMedium.inst.inputFormats,
          outputTypes: ImageMedium.inst.outputFormats,
        );

  @override
  Map<String, dynamic> get jsonForm => <String, dynamic>{
        "title": "",
        "fields": <Map<String, dynamic>>[
          JobDispatcherFormBuilder.fSingleInputPath("single_img_input_path",
              "This path should lead to an existing file with read and write access. "),
        ]
      };

  @override
  List<Widget> get otherFormWidgets => const <Widget>[
        Text(
            "This job converts one image file from one format to another. Once this job finishes convertting, it will be disposed.",
            style:
            TextStyle(fontSize: 16, fontFamily: kStylizedFontFamily))
      ];

  @override
  Map<String, dynamic> get jsonFormDecorations => const <String, dynamic>{};

  @override
  void jsonFormOnSave(dynamic res) {}

  @override
  Map<String, dynamic> get jsonFormValidators => <String, dynamic>{};
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
