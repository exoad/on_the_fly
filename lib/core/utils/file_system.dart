import 'dart:io';

import 'package:on_the_fly/shared/app.dart';
import 'package:reactive_forms/reactive_forms.dart';

final class FileSystem {
  FileSystem._();

  static final RegExp _validFilenamePattern = RegExp(r"^[\w\-. ]+$");

  /// please exclude any parent paths and also the file extension in order to
  /// avoid undesired results.
  ///
  /// invokes the internal [_validFilenamePattern] regex
  static bool isValidFilename(String name) => name.contains(_validFilenamePattern);
}

class ValidReadableFileValidator extends AsyncValidator<String> {
  @override
  Future<Map<String, dynamic>?> validate(AbstractControl<String> control) async {
    if (control.value == null || control.value!.isEmpty) {
      control.markAsTouched();
      return <String, dynamic>{
        "requiredTrue": localeMap["path validator.path_cannot_be_empty"]
      };
    }
    if (!await FileSystemEntity.isFile(control.value!)) {
      control.markAsTouched();
      return <String, dynamic>{
        "requiredTrue": localeMap["path validator.path_not_valid_file"]
      };
    }
    return null;
  }
} 
