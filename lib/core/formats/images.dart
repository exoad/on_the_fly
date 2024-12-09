import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/form_ui_transfer.dart';
import 'package:on_the_fly/core/utils/result.dart';

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
            orderForm: OrderForm(
                title:
                    "Single Image Conversion #${JobDispatcher.registeredJobDispatchers.length + 1}",
                onOrder: () {},
                isAlive: () => true,
                pumps: <String, UIPump<dynamic>>{
                  "in_file": StringInputPump(
                      label: "Input File",
                      pump: (String input) {},
                      validator: (String? input) => null),
                }));

  @override
  Map<String, dynamic> get jsonForm => <String, dynamic>{
        'fields': <Map<String, Object>>[
          <String, Object>{
            'key': 'inputKey',
            'type': 'Input',
            'label': 'Hi Group',
            'placeholder': "Hi Group flutter",
            'validator': 'digitsOnly',
            'required': true,
            'decoration': const InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              border: OutlineInputBorder(),
            ),
            'validation': (_) => true,
            'keyboardType': TextInputType.number
          },
        ]
      };

  @override
  Future<void> buildJob(BuildContext context) async {
    super.buildJob(context);
  }
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
    // TODO: implement process
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
