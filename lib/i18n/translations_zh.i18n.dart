// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'translations.i18n.dart';

String get _languageCode => 'zh';
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

class TranslationsZh extends Translations {
  const TranslationsZh();
  String get locale => "zh";
  String get languageCode => "zh";
  AppGenericsTranslationsZh get appGenerics => AppGenericsTranslationsZh(this);
  CanonicalBitsTranslationsZh get canonicalBits =>
      CanonicalBitsTranslationsZh(this);
  FilePickerTranslationsZh get filePicker => FilePickerTranslationsZh(this);
  FormatGenericTranslationsZh get formatGeneric =>
      FormatGenericTranslationsZh(this);
  SingleImgJobTranslationsZh get singleImgJob =>
      SingleImgJobTranslationsZh(this);
}

class AppGenericsTranslationsZh extends AppGenericsTranslations {
  final TranslationsZh _parent;
  const AppGenericsTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "悄悄转"
  /// ```
  String get canonical_title => """悄悄转""";

  /// ```dart
  /// "自动背后转换文件器"
  /// ```
  String get canonical_description => """自动背后转换文件器""";

  /// ```dart
  /// "没有事可干…"
  /// ```
  String get nothing_to_do => """没有事可干…""";

  /// ```dart
  /// "任务数量"
  /// ```
  String get job_count => """任务数量""";

  /// ```dart
  /// "退出"
  /// ```
  String get exit => """退出""";

  /// ```dart
  /// "处理器"
  /// ```
  String get processor => """处理器""";

  /// ```dart
  /// "调度数量"
  /// ```
  String get dispatched_amount => """调度数量""";

  /// ```dart
  /// "细节"
  /// ```
  String get description => """细节""";

  /// ```dart
  /// "支持的输入文件扩展名"
  /// ```
  String get supported_input_file_extensions => """支持的输入文件扩展名""";

  /// ```dart
  /// "支持的输出文件扩展名"
  /// ```
  String get supported_output_file_extensions => """支持的输出文件扩展名""";
}

class CanonicalBitsTranslationsZh extends CanonicalBitsTranslations {
  final TranslationsZh _parent;
  const CanonicalBitsTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "任务调度"
  /// ```
  String get job_dispatcher_formal => """任务调度""";
}

class FilePickerTranslationsZh extends FilePickerTranslations {
  final TranslationsZh _parent;
  const FilePickerTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "选择文件"
  /// ```
  String get dialog_title_pick_file => """选择文件""";

  /// ```dart
  /// "选择文件夹"
  /// ```
  String get dialog_title_pick_folder => """选择文件夹""";

  /// ```dart
  /// "使用文件选择器"
  /// ```
  String get launch => """使用文件选择器""";
}

class FormatGenericTranslationsZh extends FormatGenericTranslations {
  final TranslationsZh _parent;
  const FormatGenericTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "支持的输入"
  /// ```
  String get supported_inputs => """支持的输入""";

  /// ```dart
  /// "支持的输出"
  /// ```
  String get supported_outputs => """支持的输出""";

  /// ```dart
  /// "添加这个程序"
  /// ```
  String get push_job => """添加这个程序""";

  /// ```dart
  /// "图像类"
  /// ```
  String get image => """图像类""";

  /// ```dart
  /// "轻触查看更多信息"
  /// ```
  String get click_to_view_more => """轻触查看更多信息""";
}

class SingleImgJobTranslationsZh extends SingleImgJobTranslations {
  final TranslationsZh _parent;
  const SingleImgJobTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "单个图像"
  /// ```
  String get canonical_name => """单个图像""";

  /// ```dart
  /// "把一个图像文件变成别的文件格式"
  /// ```
  String get description => """把一个图像文件变成别的文件格式""";

  /// ```dart
  /// "XXXXX"
  /// ```
  String get proper_description => """XXXXX""";
}

Map<String, String> get translationsZhMap => {
      """app generics.canonical_title""": """悄悄转""",
      """app generics.canonical_description""": """自动背后转换文件器""",
      """app generics.nothing_to_do""": """没有事可干…""",
      """app generics.job_count""": """任务数量""",
      """app generics.exit""": """退出""",
      """app generics.processor""": """处理器""",
      """app generics.dispatched_amount""": """调度数量""",
      """app generics.description""": """细节""",
      """app generics.supported_input_file_extensions""": """支持的输入文件扩展名""",
      """app generics.supported_output_file_extensions""": """支持的输出文件扩展名""",
      """canonical bits.job_dispatcher_formal""": """任务调度""",
      """file picker.dialog_title_pick_file""": """选择文件""",
      """file picker.dialog_title_pick_folder""": """选择文件夹""",
      """file picker.launch""": """使用文件选择器""",
      """format generic.supported_inputs""": """支持的输入""",
      """format generic.supported_outputs""": """支持的输出""",
      """format generic.push_job""": """添加这个程序""",
      """format generic.image""": """图像类""",
      """format generic.click_to_view_more""": """轻触查看更多信息""",
      """single img job.canonical_name""": """单个图像""",
      """single img job.description""": """把一个图像文件变成别的文件格式""",
      """single img job.proper_description""": """XXXXX""",
    };
