import 'package:meta/meta.dart';
import 'package:on_the_fly/helpers/i18n.dart';
import 'package:on_the_fly/shared/app.dart';

extension FormatMediums on List<FormatMedium> {
  bool containsExtension(String ext) {
    for (FormatMedium medium in this) {
      if (medium._formats.keys
          .contains(ext.toLowerCase().replaceAll(RegExp(r'\s+'), ""))) {
        return true;
      }
    }
    return false;
  }

  List<String> get allExtension {
    List<String> l = <String>[];
    for (FormatMedium mediums in this) {
      l.addAll(mediums._formats.keys);
    }
    return l;
  }
}

/// describes a single instance of a file format, for example, the WAV audio format
/// is an uncompressed audio format.
class FileFormat {
  final String canonicalName;
  final bool canWrite;
  final bool canRead;

  /// formats in the same [FormatMedium] that are both Read and Write incompatible
  /// with this format
  final List<FileFormat> incompatible;

  const FileFormat(
      {required this.canonicalName,
      required this.canWrite,
      required this.canRead,
      this.incompatible = const <FileFormat>[]});

  bool isCompatible(covariant FileFormat format) => incompatible.contains(format);

  @override
  String toString() => "$canonicalName[CanRead=$canRead, CanWrite=$canWrite]";
}

/// a format medium describes a group of file formats that are related to each other, for example
/// [ImageMedium] hosts all of the file formats that represent general (bitmap) based images.
class FormatMedium {
  final LocaleProducer mediumName;
  final Map<String, FileFormat> _formats;
  final List<String> _inputTypes;
  final List<String> _outputTypes;

  @protected
  FormatMedium({
    required this.mediumName,
    required Map<String, FileFormat> formats,
  })  : _formats = formats,
        _inputTypes = <String>[],
        _outputTypes = <String>[] {
    for (MapEntry<String, FileFormat> entry in formats.entries) {
      if (entry.value.canRead) {
        _inputTypes.add(entry.key);
      }
      if (entry.value.canWrite) {
        _outputTypes.add(entry.key);
      }
    }
  }
  @override
  String toString() => "Medium:$mediumName[In=$_inputTypes, Out=$_outputTypes]";

  /// very naive checker to see if this file format can be converted between the two
  bool canConvert(FileFormat from, FileFormat to) {
    return inputFormats.contains(from) && outputFormats.contains(to);
  }

  List<FileFormat> get inputFormats {
    List<FileFormat> list = <FileFormat>[];
    for (String r in _inputTypes) {
      list.add(_formats[r]!);
    }
    return list;
  }

  List<FileFormat> get outputFormats {
    List<FileFormat> list = <FileFormat>[];
    for (String r in _outputTypes) {
      list.add(_formats[r]!);
    }
    return list;
  }

  bool isSupportedOutput(String ext) {
    return _inputTypes.contains(ext.toLowerCase().replaceAll(RegExp(r"\s+"), ""));
  }

  bool isSupportedInput(String ext) {
    return _outputTypes.contains(ext.toLowerCase().replaceAll(RegExp(r"\s+"), ""));
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
      buffer.write(inputFormats[i]);
    }
    return buffer.toString();
  }

  String get prettifyOutputFormats {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < outputFormats.length; i++) {
      buffer.write(outputFormats[i]);
    }
    return buffer.toString();
  }
}
