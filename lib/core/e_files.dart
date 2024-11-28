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

abstract class FormatMedium {
  final String mediumName;
  final List<FileFormat> inputFormats;
  final List<FileFormat> outputFormats;

  const FormatMedium._({
    required this.mediumName,
    required this.inputFormats,
    required this.outputFormats,
  });
}
