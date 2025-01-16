import 'package:meta/meta.dart';
import 'package:on_the_fly/helpers/i18n.dart';
import 'package:on_the_fly/shared/app.dart';

/// describes a single instance of a file format, for example, the WAV audio format
/// is an uncompressed audio format.
class FileFormat {
  final String canonicalName;
  final List<String> validExtensions;
  final bool canWrite;
  final bool canRead;

  /// formats in the same [FormatMedium] that are both Read and Write incompatible
  /// with this format
  final List<FileFormat> incompatible;

  const FileFormat(
      {required this.canonicalName,
      required this.validExtensions,
      required this.canWrite,
      required this.canRead,
      this.incompatible = const <FileFormat>[]});

  // maybe can be used later for whent eh user wants to override certain file formats
  void operator +(String extension) => validExtensions.add(extension);

  bool isCompatible(covariant FileFormat format) => incompatible.contains(format);

  @override
  String toString() =>
      "$canonicalName[CanRead=$canRead, CanWrite=$canWrite, ValidExtensions=$validExtensions]";
}

/// a format medium describes a group of file formats that are related to each other, for example
/// [ImageMedium] hosts all of the file formats that represent general (bitmap) based images.
class FormatMedium {
  final LocaleProducer mediumName;
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
  @override
  String toString() => "Medium:$mediumName[In=$_inputTypes, Out=$_outputTypes]";

  /// very naive checker to see if this file format can be converted between the two
  bool canConvert(FileFormat from, FileFormat to) {
    return _inputTypes.contains(from) && _outputTypes.contains(to);
  }

  List<FileFormat> get inputFormats => _inputTypes;

  List<FileFormat> get outputFormats => _outputTypes;

  bool isSupportedOutput(String ext) {
    ext = ext.toLowerCase().replaceAll(RegExp(r"\s+"), "");
    for (FileFormat format in outputFormats) {
      if (format.validExtensions.contains(ext)) {
        return true;
      }
    }
    return false;
  }

  bool isSupportedInput(String ext) {
    ext = ext.toLowerCase().replaceAll(RegExp(r"\s+"), "");
    for (FileFormat format in inputFormats) {
      if (format.validExtensions.contains(ext)) {
        return true;
      }
    }
    return false;
  }

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
