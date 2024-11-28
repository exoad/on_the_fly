import 'package:on_the_fly/core/builtin/media_img.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:path/path.dart' as paths;

typedef OutputPathHandler = String Function(
    String inputPath, ImgFileTypes outputType);

typedef OutputHandlerDescriptor = ({
  OutputPathHandler Function(dynamic) fx,
  String canonicalName,
  String description
});

final class OutputNameBuilder {
  OutputNameBuilder._();

  static OutputPathHandler simpleRandomName(
      {String allowedChars =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_",
      required int len}) {
    return (String inputPath, ImgFileTypes outputType) {
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < len; i++) {
        buffer.write(allowedChars[random.nextInt(allowedChars.length)]);
      }
      return paths.join(paths.dirname(inputPath),
          "${buffer.toString()}.${outputType.validExtensions.first}");
    };
  }

  static OutputPathHandler simpleName({required String name}) {
    return (String inputPath, ImgFileTypes outputType) {
      return paths.join(paths.dirname(inputPath),
          "$name.${outputType.validExtensions.first}");
    };
  }

  static OutputPathHandler simplePrefix({required String prefix}) =>
      (String inputPath, ImgFileTypes outputType) => paths.join(
          paths.dirname(inputPath),
          "$prefix${paths.basenameWithoutExtension(inputPath)}.${outputType.validExtensions.first}");

  static OutputPathHandler simpleSuffix({required String suffix}) =>
      (String inputPath, ImgFileTypes outputType) => paths.join(
          paths.dirname(inputPath),
          "${paths.basenameWithoutExtension(inputPath)}$suffix.${outputType.validExtensions.first}");
}

class FileCandidate {
  final String inputPath;
  final OutputPathHandler outputName;

  FileCandidate({required this.inputPath, required this.outputName});

  /// If [autoDetectFileType] returns null, then the file type is not supported and should be skipped or treated as an error.
  static ImgFileTypes? autoDetectFileType(String inputPath) {
    for (ImgFileTypes type in ImgFileTypes.inputTypes) {
      if (type.validExtensions.contains(paths.extension(inputPath))) {
        return type;
      }
    }
    return null;
  }
}

enum JobStatus {
  completed,
  failed,
  skipped;
}
