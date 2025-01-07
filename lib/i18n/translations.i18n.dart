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
  LoggerViewTranslations get loggerView => LoggerViewTranslations(this);
  DispatchedJobsTranslations get dispatchedJobs =>
      DispatchedJobsTranslations(this);
  CanonicalBitsTranslations get canonicalBits =>
      CanonicalBitsTranslations(this);
  FilePickerTranslations get filePicker => FilePickerTranslations(this);
  PathValidatorTranslations get pathValidator =>
      PathValidatorTranslations(this);
  FormatGenericTranslations get formatGeneric =>
      FormatGenericTranslations(this);
  SingleImgJobTranslations get singleImgJob => SingleImgJobTranslations(this);
  BuiltinImgProcessorTranslations get builtinImgProcessor =>
      BuiltinImgProcessorTranslations(this);
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
  /// "Open editor"
  /// ```
  String get open_editor => """Open editor""";

  /// ```dart
  /// "Hide editor"
  /// ```
  String get hide_editor => """Hide editor""";

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

  /// ```dart
  /// "No Implementation"
  /// ```
  String get no_impl => """No Implementation""";

  /// ```dart
  /// "Menu"
  /// ```
  String get menu => """Menu""";

  /// ```dart
  /// "GitHub"
  /// ```
  String get github => """GitHub""";

  /// ```dart
  /// "Third party licenses"
  /// ```
  String get third_parties => """Third party licenses""";

  /// ```dart
  /// "Jiaming Meng (Jack/exoad)"
  /// ```
  String get author_name => """Jiaming Meng (Jack/exoad)""";

  /// ```dart
  /// "Close"
  /// ```
  String get close => """Close""";

  /// ```dart
  /// "Browse"
  /// ```
  String get browse => """Browse""";

  /// ```dart
  /// "Empty"
  /// ```
  String get empty => """Empty""";

  /// ```dart
  /// "Loading"
  /// ```
  String get loading => """Loading""";

  /// ```dart
  /// "Minimize"
  /// ```
  String get minimize => """Minimize""";

  /// ```dart
  /// "Maximize"
  /// ```
  String get maximize => """Maximize""";

  /// ```dart
  /// "Restore"
  /// ```
  String get restore => """Restore""";

  /// ```dart
  /// "Clear"
  /// ```
  String get clear => """Clear""";

  /// ```dart
  /// "Scroll to bottom"
  /// ```
  String get scroll_to_bottom => """Scroll to bottom""";

  /// ```dart
  /// "Scroll to top"
  /// ```
  String get scroll_to_top => """Scroll to top""";

  /// ```dart
  /// "Incorrect"
  /// ```
  String get incorrect => """Incorrect""";

  /// ```dart
  /// "Validating"
  /// ```
  String get validating => """Validating""";
}

class LoggerViewTranslations {
  final Translations _parent;
  const LoggerViewTranslations(this._parent);

  /// ```dart
  /// "Logs"
  /// ```
  String get rmenu_tooltip => """Logs""";

  /// ```dart
  /// "Logs"
  /// ```
  String get title => """Logs""";

  /// ```dart
  /// "Log uptime"
  /// ```
  String get log_uptime => """Log uptime""";
}

class DispatchedJobsTranslations {
  final Translations _parent;
  const DispatchedJobsTranslations(this._parent);

  /// ```dart
  /// "Remove"
  /// ```
  String get remove_job_button => """Remove""";
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
}

class PathValidatorTranslations {
  final Translations _parent;
  const PathValidatorTranslations(this._parent);

  /// ```dart
  /// "Path cannot be empty"
  /// ```
  String get path_cannot_be_empty => """Path cannot be empty""";

  /// ```dart
  /// "Provided path is not a file"
  /// ```
  String get path_not_valid_file => """Provided path is not a file""";
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
  /// "Output format"
  /// ```
  String get output_format => """Output format""";

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

class BuiltinImgProcessorTranslations {
  final Translations _parent;
  const BuiltinImgProcessorTranslations(this._parent);

  /// ```dart
  /// "Builtin Image Processor"
  /// ```
  String get canonical_name => """Builtin Image Processor""";

  /// ```dart
  /// "Used for processing image files such as PNG, JPEG, etc.. This processor is builtin to OnTheFly"
  /// ```
  String get proper_description =>
      """Used for processing image files such as PNG, JPEG, etc.. This processor is builtin to OnTheFly""";
}

Map<String, String> get translationsMap => {
      """app generics.canonical_title""": """OnTheFly""",
      """app generics.canonical_description""": """Auto convert file formats""",
      """app generics.nothing_to_do""": """Nothing to do right now...""",
      """app generics.job_count""": """Jobs""",
      """app generics.exit""": """Exit""",
      """app generics.open_editor""": """Open editor""",
      """app generics.hide_editor""": """Hide editor""",
      """app generics.processor""": """Processor""",
      """app generics.dispatched_amount""": """Variants dispatched""",
      """app generics.description""": """Description""",
      """app generics.supported_input_file_extensions""":
          """Supported input file extensions""",
      """app generics.supported_output_file_extensions""":
          """Supported output file extensions""",
      """app generics.no_impl""": """No Implementation""",
      """app generics.menu""": """Menu""",
      """app generics.github""": """GitHub""",
      """app generics.third_parties""": """Third party licenses""",
      """app generics.author_name""": """Jiaming Meng (Jack/exoad)""",
      """app generics.close""": """Close""",
      """app generics.browse""": """Browse""",
      """app generics.empty""": """Empty""",
      """app generics.loading""": """Loading""",
      """app generics.minimize""": """Minimize""",
      """app generics.maximize""": """Maximize""",
      """app generics.restore""": """Restore""",
      """app generics.clear""": """Clear""",
      """app generics.scroll_to_bottom""": """Scroll to bottom""",
      """app generics.scroll_to_top""": """Scroll to top""",
      """app generics.incorrect""": """Incorrect""",
      """app generics.validating""": """Validating""",
      """logger view.rmenu_tooltip""": """Logs""",
      """logger view.title""": """Logs""",
      """logger view.log_uptime""": """Log uptime""",
      """dispatched jobs.remove_job_button""": """Remove""",
      """canonical bits.job_dispatcher_formal""": """Job Dispatcher""",
      """file picker.dialog_title_pick_file""": """Select a file""",
      """file picker.dialog_title_pick_folder""": """Select a folder""",
      """path validator.path_cannot_be_empty""": """Path cannot be empty""",
      """path validator.path_not_valid_file""":
          """Provided path is not a file""",
      """format generic.supported_inputs""": """Supported Inputs""",
      """format generic.supported_outputs""": """Supported Outputs""",
      """format generic.output_format""": """Output format""",
      """format generic.push_job""": """Add this job""",
      """format generic.image""": """Images""",
      """format generic.click_to_view_more""": """Click for more info""",
      """single img job.canonical_name""": """Single Image""",
      """single img job.description""":
          """Converts a single image file from one format to another""",
      """single img job.proper_description""":
          """This job is a simple way to provide a simple way to convert just one image file from one format to another format. If you want to convert multiple files or watch a folder, you should seek for alternative methods.""",
      """builtin img processor.canonical_name""": """Builtin Image Processor""",
      """builtin img processor.proper_description""":
          """Used for processing image files such as PNG, JPEG, etc.. This processor is builtin to OnTheFly""",
    };
