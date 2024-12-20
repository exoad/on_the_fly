import 'package:meta/meta.dart';
import 'package:on_the_fly/shared/app.dart';

class FileFormat {
  final String canonicalName;
  final List<String> validExtensions;
  final bool canWrite;
  final bool canRead;

  const FileFormat({
    required this.canonicalName,
    required this.validExtensions,
    required this.canWrite,
    required this.canRead,
  });
}

class FormatMedium {
  final String mediumName;
  final Map<String, FileFormat> _formats;
  final List<FileFormat> _inputTypes;
  final List<FileFormat> _outputTypes;

  @protected
  FormatMedium({
    required this.mediumName,
    required Map<String, FileFormat> formats,
  })  : _formats = formats,
        _inputTypes = <FileFormat>[],
        _outputTypes = <FileFormat>[] {
    for (MapEntry<String, FileFormat> entry in formats.entries) {
      if (entry.value.canRead) {
        _inputTypes.add(entry.value);
      }
      if (entry.value.canWrite) {
        _outputTypes.add(entry.value);
      }
    }
  }

  List<FileFormat> get inputFormats => _inputTypes;

  List<FileFormat> get outputFormats => _outputTypes;

  FileFormat operator [](String key) {
    if (!_formats.containsKey(key) && kAllowDebugWarnings) {
      throw ArgumentError(
          "Invalid key: $key"); // programmer error, go fuck yourself !!! (kys)
    }
    return _formats[key]!; // fuck dead code warnings lmao
  }

  String get prettyifyInputFormats {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < inputFormats.length; i++) {
      FileFormat f = inputFormats[i];
      for (int j = 0; j < f.validExtensions.length; j++) {
        buffer.write("*.${f.validExtensions[j]}");
        if (!(i == inputFormats.length - 1 && j == f.validExtensions.length - 1)) {
          buffer.write(", ");
        }
      }
    }
    return buffer.toString();
  }

  String get prettifyOutputFormats {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < outputFormats.length; i++) {
      FileFormat f = outputFormats[i];
      for (int j = 0; j < f.validExtensions.length; j++) {
        buffer.write("*.${f.validExtensions[j]}");
        if (!(i == outputFormats.length - 1 && j == f.validExtensions.length - 1)) {
          buffer.write(", ");
        }
      }
    }
    return buffer.toString();
  }
}
