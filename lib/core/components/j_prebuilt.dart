import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/components/asyncs.dart';
import 'package:on_the_fly/client/components/prefers.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/core/components/job_component.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:path/path.dart' as paths;
import 'package:provider/provider.dart';

final class FilePathValidators {
  FilePathValidators._();

  static Future<String?> validateFilePath(String? value) async {
    if (value == null || value.isEmpty) {
      return InternationalizationNotifier().i18n.pathValidator.path_cannot_be_empty;
    }
    if (!await FileSystemEntity.isFile(value)) {
      return InternationalizationNotifier().i18n.pathValidator.path_not_valid_file;
    }
    return null;
  }
}

class JobSinglePathPickerActionable extends StatefulWidget {
  final void Function(String str) onChanged;
  final FormatMedium formatMedium;
  final String filePickerLabel;
  final String hintLabel;
  final List<String> allowedExtensions;
  final String? filePickerDialogTitle;

  const JobSinglePathPickerActionable({
    super.key,
    this.filePickerDialogTitle,
    required this.formatMedium,
    required this.onChanged,
    required this.allowedExtensions,
    required this.filePickerLabel,
    this.hintLabel = ".../users/downloads/...",
  });

  @override
  State<JobSinglePathPickerActionable> createState() =>
      _JobSinglePathPickerActionableState();
}

class _JobSinglePathPickerActionableState extends State<JobSinglePathPickerActionable> {
  String _pathContent = "";
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: AsyncTextFormField(
        validationDebounce: const Duration(milliseconds: 120),
        controller: _textEditingController,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: Provider.of<InternationalizationNotifier>(context)
              .i18n
              .formatGeneric
              .input_file_path,
          hintText: widget.hintLabel,
          counterText: _pathContent.length > 1
              ? paths.extension(_pathContent).substring(1).toUpperCase()
              : "",
          suffixIcon: PrefersTextButtonIcon(
            style: Theme.of(context).textButtonTheme.style!.copyWith(
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  ),
                ),
            icon: const Icon(Ionicons.folder_outline),
            label: Text(
              widget.filePickerLabel,
              style: const TextStyle(fontSize: 14),
            ),
            onPressed: () async {
              FilePickerResult? res = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                dialogTitle: widget.filePickerDialogTitle,
                type: widget.allowedExtensions.isEmpty ? FileType.any : FileType.custom,
                allowedExtensions: widget.allowedExtensions,
              );
              if (res == null) {
                logger.info("FilePicker#$hashCode ignored native_picker");
              } else {
                setState(() {
                  _pathContent = res.files[0].path!;
                  _textEditingController.text = _pathContent;
                });
              }
            },
          ),
        ),
        validator: (String? value) async {
          String? validFile = await FilePathValidators.validateFilePath(value);
          if (validFile != null) {
            return validFile;
          }
          String ext = paths.extension(value!).substring(
              1); // since paths.extension will return the ".", we need to remove it
          if (!widget.formatMedium.isSupportedOutput(ext)) {
            // we use bang on value because the previous validateFilePath call has a null check that returns a value to validFile
            return (context.mounted
                    ? Provider.of<InternationalizationNotifier>(context, listen: false)
                    : InternationalizationNotifier())
                .i18n
                .appGenerics
                .MIX_is_not_supported(ext);
          }
          return null;
        },
      ),
    );
  }
}

class JobBasicOutputPathBuilder extends StatefulWidget {
  final List<FileFormat> formats;
  final Widget? chipIcon;
  final String initialFolder;
  final void Function(String Function(String args)) onDone;

  const JobBasicOutputPathBuilder(
      {super.key,
      this.chipIcon,
      required this.formats,
      required this.onDone,
      required this.initialFolder});

  @override
  State<JobBasicOutputPathBuilder> createState() => _JobBasicOutputPathBuilderState();
}

class _JobBasicOutputPathBuilderState extends State<JobBasicOutputPathBuilder> {
  late List<SpinnerChip<FileFormat>> _chipsPrecache;
  late TextEditingController _controller;
  FileFormat? _selectedFormat;

  @override
  void initState() {
    super.initState();
    _chipsPrecache = SpinnerChip.fromRelated(
        widget.formats.map((FileFormat format) => (format.canonicalName, format)),
        widget.chipIcon);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrefersTextButtonIcon(
              label: Text(Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .appGenerics
                  .folder),
              icon: const Icon(Ionicons.file_tray)),
          const SizedBox(width: kTotalAppMargin),
          Expanded(
            child: AsyncTextFormField(
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: Text(
                        Provider.of<InternationalizationNotifier>(context)
                            .i18n
                            .formatGeneric
                            .output_builder,
                        style: const TextStyle(fontSize: 14))),
                validator: (String? value) async {
                  return "";
                },
                validationDebounce: const Duration(milliseconds: 100)),
          ),
          const SizedBox(width: kTotalAppMargin),
          JobSimpleSpinner<FileFormat>(
            takeUpVertical: true,
            label: Provider.of<InternationalizationNotifier>(context)
                .i18n
                .appGenerics
                .format,
            leadingIcon: const Icon(Ionicons.document),
            chips: _chipsPrecache,
            onSelect: (FileFormat? format) => setState(() => _selectedFormat = format),
          )
        ],
      ),
    );
  }
}
