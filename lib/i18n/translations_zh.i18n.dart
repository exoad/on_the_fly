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
  LoggerViewTranslationsZh get loggerView => LoggerViewTranslationsZh(this);
  DispatchedJobsTranslationsZh get dispatchedJobs =>
      DispatchedJobsTranslationsZh(this);
  CanonicalBitsTranslationsZh get canonicalBits =>
      CanonicalBitsTranslationsZh(this);
  FilePickerTranslationsZh get filePicker => FilePickerTranslationsZh(this);
  PathValidatorTranslationsZh get pathValidator =>
      PathValidatorTranslationsZh(this);
  FormatGenericTranslationsZh get formatGeneric =>
      FormatGenericTranslationsZh(this);
  BuiltinImgProcessorTranslationsZh get builtinImgProcessor =>
      BuiltinImgProcessorTranslationsZh(this);
  JobStyleAdvertsTranslationsZh get jobStyleAdverts =>
      JobStyleAdvertsTranslationsZh(this);
  JobPrebuiltTranslationsZh get jobPrebuilt => JobPrebuiltTranslationsZh(this);
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
  /// "打开编辑器"
  /// ```
  String get open_editor => """打开编辑器""";

  /// ```dart
  /// "隐藏编辑器"
  /// ```
  String get hide_editor => """隐藏编辑器""";

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

  /// ```dart
  /// "无实现"
  /// ```
  String get no_impl => """无实现""";

  /// ```dart
  /// "菜单"
  /// ```
  String get menu => """菜单""";

  /// ```dart
  /// "GitHub"
  /// ```
  String get github => """GitHub""";

  /// ```dart
  /// "第三方许可证"
  /// ```
  String get third_parties => """第三方许可证""";

  /// ```dart
  /// "孟嘉明 (Jack/exoad)"
  /// ```
  String get author_name => """孟嘉明 (Jack/exoad)""";

  /// ```dart
  /// "关闭"
  /// ```
  String get close => """关闭""";

  /// ```dart
  /// "加上"
  /// ```
  String get add_this => """加上""";

  /// ```dart
  /// "文件夹"
  /// ```
  String get folder => """文件夹""";

  /// ```dart
  /// "浏览"
  /// ```
  String get browse => """浏览""";

  /// ```dart
  /// "空"
  /// ```
  String get empty => """空""";

  /// ```dart
  /// "加载中"
  /// ```
  String get loading => """加载中""";

  /// ```dart
  /// "最小化"
  /// ```
  String get minimize => """最小化""";

  /// ```dart
  /// "创建于"
  /// ```
  String get created_on => """创建于""";

  /// ```dart
  /// "最大化"
  /// ```
  String get maximize => """最大化""";

  /// ```dart
  /// "恢复"
  /// ```
  String get restore => """恢复""";

  /// ```dart
  /// "清除"
  /// ```
  String get clear => """清除""";

  /// ```dart
  /// "滚动到底部"
  /// ```
  String get scroll_to_bottom => """滚动到底部""";

  /// ```dart
  /// "回到顶部"
  /// ```
  String get scroll_to_top => """回到顶部""";

  /// ```dart
  /// "不正确"
  /// ```
  String get incorrect => """不正确""";

  /// ```dart
  /// "验证中"
  /// ```
  String get validating => """验证中""";

  /// ```dart
  /// "格式"
  /// ```
  String get format => """格式""";

  /// ```dart
  /// "不支持 $item"
  /// ```
  String MIX_is_not_supported(dynamic item) => """不支持 $item""";

  /// ```dart
  /// "开始"
  /// ```
  String get start => """开始""";

  /// ```dart
  /// "不适配"
  /// ```
  String get incompatible_with => """不适配""";
}

class LoggerViewTranslationsZh extends LoggerViewTranslations {
  final TranslationsZh _parent;
  const LoggerViewTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "日志"
  /// ```
  String get rmenu_tooltip => """日志""";

  /// ```dart
  /// "日志"
  /// ```
  String get title => """日志""";

  /// ```dart
  /// "记录运行时间"
  /// ```
  String get log_uptime => """记录运行时间""";
}

class DispatchedJobsTranslationsZh extends DispatchedJobsTranslations {
  final TranslationsZh _parent;
  const DispatchedJobsTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "删除"
  /// ```
  String get remove_job_button => """删除""";
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
}

class PathValidatorTranslationsZh extends PathValidatorTranslations {
  final TranslationsZh _parent;
  const PathValidatorTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "路径不能为空"
  /// ```
  String get path_cannot_be_empty => """路径不能为空""";

  /// ```dart
  /// "提供的路径不是文件"
  /// ```
  String get path_not_valid_file => """提供的路径不是文件""";
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
  /// "输出格式"
  /// ```
  String get output_format => """输出格式""";

  /// ```dart
  /// "输入格式"
  /// ```
  String get input_file_path => """输入格式""";

  /// ```dart
  /// "输出生成器"
  /// ```
  String get output_builder => """输出生成器""";

  /// ```dart
  /// "图像类"
  /// ```
  String get image => """图像类""";

  /// ```dart
  /// "转换"
  /// ```
  String get conversion => """转换""";

  /// ```dart
  /// "修改"
  /// ```
  String get transmutation => """修改""";

  /// ```dart
  /// "轻触查看更多信息"
  /// ```
  String get click_to_view_more => """轻触查看更多信息""";
}

class BuiltinImgProcessorTranslationsZh
    extends BuiltinImgProcessorTranslations {
  final TranslationsZh _parent;
  const BuiltinImgProcessorTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "内置图像处理器"
  /// ```
  String get canonical_name => """内置图像处理器""";

  /// ```dart
  /// "用于处理图像文件，例如 PNG、JPEG 等。此处理器内置于悄悄转中。"
  /// ```
  String get proper_description => """用于处理图像文件，例如 PNG、JPEG 等。此处理器内置于悄悄转中。""";
}

class JobStyleAdvertsTranslationsZh extends JobStyleAdvertsTranslations {
  final TranslationsZh _parent;
  const JobStyleAdvertsTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "点击查看更多操作"
  /// ```
  String get adverts_click_for_more_actions => """点击查看更多操作""";

  /// ```dart
  /// "单个文件"
  /// ```
  String get single_file_title => """单个文件""";

  /// ```dart
  /// "将一个文件从一种格式转换为另一种格式。"
  /// ```
  String get single_file_description => """将一个文件从一种格式转换为另一种格式。""";

  /// ```dart
  /// "多个文件"
  /// ```
  String get multiple_files_title => """多个文件""";

  /// ```dart
  /// "将多个相同格式的文件转换为另一种文件格式。"
  /// ```
  String get multiple_files_description => """将多个相同格式的文件转换为另一种文件格式。""";

  /// ```dart
  /// "文件夹监视"
  /// ```
  String get watch_folder_title => """文件夹监视""";

  /// ```dart
  /// "自动将文件夹内特定格式的文件转换为另一种格式。"
  /// ```
  String get watch_folder_description => """自动将文件夹内特定格式的文件转换为另一种格式。""";

  /// ```dart
  /// "支持的文件类型"
  /// ```
  String get supported_format_mediums => """支持的文件类型""";
}

class JobPrebuiltTranslationsZh extends JobPrebuiltTranslations {
  final TranslationsZh _parent;
  const JobPrebuiltTranslationsZh(this._parent) : super(_parent);

  /// ```dart
  /// "选文件"
  /// ```
  String get single_path_actionable_file_picker_label => """选文件""";
}

Map<String, String> get translationsZhMap => {
      """app generics.canonical_title""": """悄悄转""",
      """app generics.canonical_description""": """自动背后转换文件器""",
      """app generics.nothing_to_do""": """没有事可干…""",
      """app generics.job_count""": """任务数量""",
      """app generics.exit""": """退出""",
      """app generics.open_editor""": """打开编辑器""",
      """app generics.hide_editor""": """隐藏编辑器""",
      """app generics.processor""": """处理器""",
      """app generics.dispatched_amount""": """调度数量""",
      """app generics.description""": """细节""",
      """app generics.supported_input_file_extensions""": """支持的输入文件扩展名""",
      """app generics.supported_output_file_extensions""": """支持的输出文件扩展名""",
      """app generics.no_impl""": """无实现""",
      """app generics.menu""": """菜单""",
      """app generics.github""": """GitHub""",
      """app generics.third_parties""": """第三方许可证""",
      """app generics.author_name""": """孟嘉明 (Jack/exoad)""",
      """app generics.close""": """关闭""",
      """app generics.add_this""": """加上""",
      """app generics.folder""": """文件夹""",
      """app generics.browse""": """浏览""",
      """app generics.empty""": """空""",
      """app generics.loading""": """加载中""",
      """app generics.minimize""": """最小化""",
      """app generics.created_on""": """创建于""",
      """app generics.maximize""": """最大化""",
      """app generics.restore""": """恢复""",
      """app generics.clear""": """清除""",
      """app generics.scroll_to_bottom""": """滚动到底部""",
      """app generics.scroll_to_top""": """回到顶部""",
      """app generics.incorrect""": """不正确""",
      """app generics.validating""": """验证中""",
      """app generics.format""": """格式""",
      """app generics.start""": """开始""",
      """app generics.incompatible_with""": """不适配""",
      """logger view.rmenu_tooltip""": """日志""",
      """logger view.title""": """日志""",
      """logger view.log_uptime""": """记录运行时间""",
      """dispatched jobs.remove_job_button""": """删除""",
      """canonical bits.job_dispatcher_formal""": """任务调度""",
      """file picker.dialog_title_pick_file""": """选择文件""",
      """file picker.dialog_title_pick_folder""": """选择文件夹""",
      """path validator.path_cannot_be_empty""": """路径不能为空""",
      """path validator.path_not_valid_file""": """提供的路径不是文件""",
      """format generic.supported_inputs""": """支持的输入""",
      """format generic.supported_outputs""": """支持的输出""",
      """format generic.output_format""": """输出格式""",
      """format generic.input_file_path""": """输入格式""",
      """format generic.output_builder""": """输出生成器""",
      """format generic.image""": """图像类""",
      """format generic.conversion""": """转换""",
      """format generic.transmutation""": """修改""",
      """format generic.click_to_view_more""": """轻触查看更多信息""",
      """builtin img processor.canonical_name""": """内置图像处理器""",
      """builtin img processor.proper_description""":
          """用于处理图像文件，例如 PNG、JPEG 等。此处理器内置于悄悄转中。""",
      """job style adverts.adverts_click_for_more_actions""": """点击查看更多操作""",
      """job style adverts.single_file_title""": """单个文件""",
      """job style adverts.single_file_description""":
          """将一个文件从一种格式转换为另一种格式。""",
      """job style adverts.multiple_files_title""": """多个文件""",
      """job style adverts.multiple_files_description""":
          """将多个相同格式的文件转换为另一种文件格式。""",
      """job style adverts.watch_folder_title""": """文件夹监视""",
      """job style adverts.watch_folder_description""":
          """自动将文件夹内特定格式的文件转换为另一种格式。""",
      """job style adverts.supported_format_mediums""": """支持的文件类型""",
      """job prebuilt.single_path_actionable_file_picker_label""": """选文件""",
    };
