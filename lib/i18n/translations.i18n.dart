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
  AppGenericsTranslations get appGenerics => AppGenericsTranslations(this);
  CanonicalBitsTranslations get canonicalBits =>
      CanonicalBitsTranslations(this);
  FilePickerTranslations get filePicker => FilePickerTranslations(this);
  FormatGenericTranslations get formatGeneric =>
      FormatGenericTranslations(this);
  SingleImgJobTranslations get singleImgJob => SingleImgJobTranslations(this);
}

class AppGenericsTranslations {
  final Translations _parent;
  const AppGenericsTranslations(this._parent);

  /// ```dart
  /// "OnTheFly"
  /// ```
  String get canonical_title => """OnTheFly""";

  /// ```dart
  /// "Auto convert file formats"
  /// ```
  String get canonical_description => """Auto convert file formats""";

  /// ```dart
  /// "Nothing to do right now..."
  /// ```
  String get nothing_to_do => """Nothing to do right now...""";

  /// ```dart
  /// "Jobs"
  /// ```
  String get job_count => """Jobs""";

  /// ```dart
  /// "Exit"
  /// ```
  String get exit => """Exit""";

  /// ```dart
  /// "Processor"
  /// ```
  String get processor => """Processor""";

  /// ```dart
  /// "Variants dispatched"
  /// ```
  String get dispatched_amount => """Variants dispatched""";

  /// ```dart
  /// "Description"
  /// ```
  String get description => """Description""";

  /// ```dart
  /// "Supported input file extensions"
  /// ```
  String get supported_input_file_extensions =>
      """Supported input file extensions""";

  /// ```dart
  /// "Supported output file extensions"
  /// ```
  String get supported_output_file_extensions =>
      """Supported output file extensions""";
}

class CanonicalBitsTranslations {
  final Translations _parent;
  const CanonicalBitsTranslations(this._parent);

  /// ```dart
  /// "Job Dispatcher"
  /// ```
  String get job_dispatcher_formal => """Job Dispatcher""";
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

  /// ```dart
  /// "Click for more info"
  /// ```
  String get click_to_view_more => """Click for more info""";
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

  /// ```dart
  /// "This job is a simple way to provide a simple way to convert just one image file from one format to another format. If you want to convert multiple files or watch a folder, you should seek for alternative methods."
  /// ```
  String get proper_description =>
      """This job is a simple way to provide a simple way to convert just one image file from one format to another format. If you want to convert multiple files or watch a folder, you should seek for alternative methods.""";
}

Map<String, String> get translationsMap => {
      """app generics.canonical_title""": """OnTheFly""",
      """app generics.canonical_description""": """Auto convert file formats""",
      """app generics.nothing_to_do""": """Nothing to do right now...""",
      """app generics.job_count""": """Jobs""",
      """app generics.exit""": """Exit""",
      """app generics.processor""": """Processor""",
      """app generics.dispatched_amount""": """Variants dispatched""",
      """app generics.description""": """Description""",
      """app generics.supported_input_file_extensions""":
          """Supported input file extensions""",
      """app generics.supported_output_file_extensions""":
          """Supported output file extensions""",
      """canonical bits.job_dispatcher_formal""": """Job Dispatcher""",
      """file picker.dialog_title_pick_file""": """Select a file""",
      """file picker.dialog_title_pick_folder""": """Select a folder""",
      """file picker.launch""": """Use file picker""",
      """format generic.supported_inputs""": """Supported Inputs""",
      """format generic.supported_outputs""": """Supported Outputs""",
      """format generic.push_job""": """Add this job""",
      """format generic.image""": """Images""",
      """format generic.click_to_view_more""": """Click for more info""",
      """single img job.canonical_name""": """Single Image""",
      """single img job.description""":
          """Converts a single image file from one format to another""",
      """single img job.proper_description""":
          """This job is a simple way to provide a simple way to convert just one image file from one format to another format. If you want to convert multiple files or watch a folder, you should seek for alternative methods.""",
    };
