import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/components/asyncs.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/shared/app.dart';
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
  // final Future<String?> Function(String? str) validator;
  final FormatMedium formatMedium;
  final String canonicalLabel;
  final String hintLabel;
  final List<String> allowedExtensions;
  final String? filePickerDialogTitle;
  final String filePickerLabel;

  const JobSinglePathPickerActionable({
    super.key,
    this.filePickerDialogTitle,
    required this.formatMedium,
    required this.onChanged,
    required this.allowedExtensions,
    // required this.validator,
    required this.canonicalLabel,
    this.hintLabel = ".../users/downloads/...",
    required this.filePickerLabel,
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
    return
        // ExpansionTile(
        //     visualDensity: VisualDensity.compact,
        //     enableFeedback: false,
        //     showTrailingIcon: true,
        //     title: Text(widget.canonicalLabel,
        //         style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        //     subtitle: Text(
        //         isPathContentEmpty
        //             ? Provider.of<InternationalizationNotifier>(context, listen: false)
        //                 .i18n
        //                 .appGenerics
        //                 .empty
        //             : _pathContent,
        //         style: TextStyle(
        //             fontSize: 12,
        //             fontWeight: isPathContentEmpty ? FontWeight.w500 : FontWeight.normal,
        //             color: isPathContentEmpty ? kThemeNeedAction : kThemePrimaryFg2)),
        //     children: <Widget>[
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(widget.canonicalLabel, style: const TextStyle(fontSize: 14)),
        // const SizedBox(height: 4),
        Row(
          children: <Widget>[
            Expanded(
              child: AsyncTextFormField(
                validationDebounce: const Duration(milliseconds: 120),
                controller: _textEditingController,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: widget.canonicalLabel,
                  hintText: widget.hintLabel,
                  suffix: TextButton.icon(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                          visualDensity: VisualDensity.compact,
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
                        type: widget.allowedExtensions.isEmpty
                            ? FileType.any
                            : FileType.custom,
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
                            ? Provider.of<InternationalizationNotifier>(context,
                                listen: false)
                            : InternationalizationNotifier())
                        .i18n
                        .appGenerics
                        .MIX_is_not_supported(ext);
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 6), // Adds space between the text field and button
          ],
        ),
      ],
    );

    // ]);
  }
}
