import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:path/path.dart' as paths;

typedef OutputPathHandler = String Function(
    String inputPath, FileFormat outputType);

/// a generator class for helping with producing proper output names
///
/// probably going to be hardcoded with the ui and other ux features
final class OutputNameBuilder {
  OutputNameBuilder._();

  static final Map<String, Function> _registeredOutputHandlers =
      <String, Function>{
    "Simple Random Name": simpleRandomName,
    "Simple Name": simpleName,
    "Simple Prefix": simplePrefix,
    "Simple Suffix": simpleSuffix
  };

  static Map<String, Function> get registeredOutputHandlers =>
      _registeredOutputHandlers;

  static OutputPathHandler simpleRandomName(
      {String allowedChars =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_",
      required int len}) {
    return (String inputPath, FileFormat outputType) {
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < len; i++) {
        buffer.write(allowedChars[random.nextInt(allowedChars.length)]);
      }
      return paths.join(paths.dirname(inputPath),
          "${buffer.toString()}.${outputType.validExtensions.first}");
    };
  }

  static OutputPathHandler simpleName({required String name}) {
    return (String inputPath, FileFormat outputType) {
      return paths.join(paths.dirname(inputPath),
          "$name.${outputType.validExtensions.first}");
    };
  }

  static OutputPathHandler simplePrefix({required String prefix}) =>
      (String inputPath, FileFormat outputType) => paths.join(
          paths.dirname(inputPath),
          "$prefix${paths.basenameWithoutExtension(inputPath)}.${outputType.validExtensions.first}");

  static OutputPathHandler simpleSuffix({required String suffix}) =>
      (String inputPath, FileFormat outputType) => paths.join(
          paths.dirname(inputPath),
          "${paths.basenameWithoutExtension(inputPath)}$suffix.${outputType.validExtensions.first}");
}

enum JobStatus {
  completed,
  failed,
  skipped;
}
