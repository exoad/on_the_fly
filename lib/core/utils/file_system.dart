final class FileSystem {
  FileSystem._();

  static final RegExp _validFilenamePattern = RegExp(r"^[\w\-. ]+$");

  /// please exclude any parent paths and also the file extension in order to
  /// avoid undesired results.
  ///
  /// invokes the internal [_validFilenamePattern] regex
  static bool isValidFilename(String name) => name.contains(_validFilenamePattern);
}
