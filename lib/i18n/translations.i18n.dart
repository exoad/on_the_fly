// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;

String get _languageCode => 'en';
String _plural(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) =>
    i18n.plural(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );
String _ordinal(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) =>
    i18n.ordinal(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );
String _cardinal(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) =>
    i18n.cardinal(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );

class Translations {
  const Translations();
  String get locale => "en";
  String get languageCode => "en";
  FilePickerTranslations get filePicker => FilePickerTranslations(this);
  FormatGenericTranslations get formatGeneric =>
      FormatGenericTranslations(this);
  SingleImgJobTranslations get singleImgJob => SingleImgJobTranslations(this);
}

class FilePickerTranslations {
  final Translations _parent;
  const FilePickerTranslations(this._parent);

  /// ```dart
  /// "Select a file"
  /// ```
  String get dialog_title_pick_file => """Select a file""";

  /// ```dart
  /// "Select a folder"
  /// ```
  String get dialog_title_pick_folder => """Select a folder""";

  /// ```dart
  /// "Use file picker"
  /// ```
  String get launch => """Use file picker""";
}

class FormatGenericTranslations {
  final Translations _parent;
  const FormatGenericTranslations(this._parent);

  /// ```dart
  /// "Supported Inputs"
  /// ```
  String get supported_inputs => """Supported Inputs""";

  /// ```dart
  /// "Supported Outputs"
  /// ```
  String get supported_outputs => """Supported Outputs""";

  /// ```dart
  /// "Add this job"
  /// ```
  String get push_job => """Add this job""";

  /// ```dart
  /// "Images"
  /// ```
  String get image => """Images""";
}

class SingleImgJobTranslations {
  final Translations _parent;
  const SingleImgJobTranslations(this._parent);

  /// ```dart
  /// "Single Image"
  /// ```
  String get canonical_name => """Single Image""";

  /// ```dart
  /// "Converts a single image file from one format to another"
  /// ```
  String get description =>
      """Converts a single image file from one format to another""";
}

Map<String, String> get translationsMap => {
      """file picker.dialog_title_pick_file""": """Select a file""",
      """file picker.dialog_title_pick_folder""": """Select a folder""",
      """file picker.launch""": """Use file picker""",
      """format generic.supported_inputs""": """Supported Inputs""",
      """format generic.supported_outputs""": """Supported Outputs""",
      """format generic.push_job""": """Add this job""",
      """format generic.image""": """Images""",
      """single img job.canonical_name""": """Single Image""",
      """single img job.description""":
          """Converts a single image file from one format to another""",
    };
