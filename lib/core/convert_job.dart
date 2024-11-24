import 'package:auto_img/core/e_files.dart';
import 'package:auto_img/shared/app.dart';
import 'package:path/path.dart' as paths;

typedef Status = ({JobStatus status, String message});

abstract class ConvertJob {
  final String canonicalTitle;
  final String canonicalSubtitle;
  final String canonicalDescription;
  final List<ImgFileTypes> supportedInputs;
  final ImgFileTypes outputType;
  bool isDead;

  ConvertJob(
      {required this.canonicalTitle,
      required this.canonicalSubtitle,
      required this.canonicalDescription,
      required this.supportedInputs,
      required this.outputType,
      this.isDead = false});

  Status convert(FileCandidate job);
}

typedef OutputPathHandler = String Function(
    String inputPath, ImgFileTypes outputType);

final class OutputNameBuilder {
  static OutputPathHandler simpleRandomName(
      {String allowedChars =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_",
      required int len}) {
    return (String inputPath, ImgFileTypes outputType) {
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < len; i++) {
        buffer
            .write(allowedChars[random.nextInt(allowedChars.length)]);
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

  static OutputPathHandler simplePrefix({required String prefix}) {
    return (String inputPath, ImgFileTypes outputType) {
      return paths.join(paths.dirname(inputPath),
          "$prefix${paths.basename(inputPath)}");
    };
  }
}

class FileCandidate {
  final String inputPath;
  final OutputPathHandler outputName;

  FileCandidate({required this.inputPath, required this.outputName});
}

enum JobStatus {
  completed,
  failed,
  skipped;
}
