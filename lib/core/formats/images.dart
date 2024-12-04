import 'package:meta/meta.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/form_ui_transfer.dart';

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
class SingleImgJobDispatcher extends JobDispatcher<FileFormat> {
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
}
