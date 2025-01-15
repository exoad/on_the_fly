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
  BuiltinImgProcessorTranslations get builtinImgProcessor =>
      BuiltinImgProcessorTranslations(this);
  JobStyleAdvertsTranslations get jobStyleAdverts =>
      JobStyleAdvertsTranslations(this);
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
  /// "Add"
  /// ```
  String get add_this => """Add""";

  /// ```dart
  /// "Folder"
  /// ```
  String get folder => """Folder""";

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

  /// ```dart
  /// "Output"
  /// ```
  String get format => """Output""";

  /// ```dart
  /// "$item is not supported"
  /// ```
  String MIX_is_not_supported(dynamic item) => """$item is not supported""";

  /// ```dart
  /// "Start"
  /// ```
  String get start => """Start""";

  /// ```dart
  /// "Incompatible with"
  /// ```
  String get incompatible_with => """Incompatible with""";
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
  /// "Input file path"
  /// ```
  String get input_file_path => """Input file path""";

  /// ```dart
  /// "Output builder"
  /// ```
  String get output_builder => """Output builder""";

  /// ```dart
  /// "Images"
  /// ```
  String get image => """Images""";

  /// ```dart
  /// "Click for more info"
  /// ```
  String get click_to_view_more => """Click for more info""";
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

class JobStyleAdvertsTranslations {
  final Translations _parent;
  const JobStyleAdvertsTranslations(this._parent);

  /// ```dart
  /// "Click for more actions"
  /// ```
  String get adverts_click_for_more_actions => """Click for more actions""";

  /// ```dart
  /// "Single File"
  /// ```
  String get single_file_title => """Single File""";

  /// ```dart
  /// "Convert one file from one format to another format."
  /// ```
  String get single_file_description =>
      """Convert one file from one format to another format.""";

  /// ```dart
  /// "Multiple Files"
  /// ```
  String get multiple_files_title => """Multiple Files""";

  /// ```dart
  /// "Convert multiple files of the same format medium to another file format"
  /// ```
  String get multiple_files_description =>
      """Convert multiple files of the same format medium to another file format""";

  /// ```dart
  /// "Watch Folder"
  /// ```
  String get watch_folder_title => """Watch Folder""";

  /// ```dart
  /// "Automatically convert files with specific formats to another format within a folder."
  /// ```
  String get watch_folder_description =>
      """Automatically convert files with specific formats to another format within a folder.""";

  /// ```dart
  /// "Supported File Types"
  /// ```
  String get supported_format_mediums => """Supported File Types""";
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
      """app generics.add_this""": """Add""",
      """app generics.folder""": """Folder""",
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
      """app generics.format""": """Output""",
      """app generics.start""": """Start""",
      """app generics.incompatible_with""": """Incompatible with""",
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
      """format generic.input_file_path""": """Input file path""",
      """format generic.output_builder""": """Output builder""",
      """format generic.image""": """Images""",
      """format generic.click_to_view_more""": """Click for more info""",
      """builtin img processor.canonical_name""": """Builtin Image Processor""",
      """builtin img processor.proper_description""":
          """Used for processing image files such as PNG, JPEG, etc.. This processor is builtin to OnTheFly""",
      """job style adverts.adverts_click_for_more_actions""":
          """Click for more actions""",
      """job style adverts.single_file_title""": """Single File""",
      """job style adverts.single_file_description""":
          """Convert one file from one format to another format.""",
      """job style adverts.multiple_files_title""": """Multiple Files""",
      """job style adverts.multiple_files_description""":
          """Convert multiple files of the same format medium to another file format""",
      """job style adverts.watch_folder_title""": """Watch Folder""",
      """job style adverts.watch_folder_description""":
          """Automatically convert files with specific formats to another format within a folder.""",
      """job style adverts.supported_format_mediums""":
          """Supported File Types""",
    };
