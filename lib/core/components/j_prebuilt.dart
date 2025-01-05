import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/theme.dart';
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
  final Future<String?> Function(String? str) validator;
  final String canonicalLabel;
  final String hintLabel;
  final List<String> allowedExtensions;
  final String? filePickerDialogTitle;
  final String filePickerLabel;

  const JobSinglePathPickerActionable({
    super.key,
    this.filePickerDialogTitle,
    required this.onChanged,
    required this.allowedExtensions,
    required this.validator,
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
  String? _errnMsg;

  @override
  Widget build(BuildContext context) {
    bool isPathContentEmpty = _pathContent.isEmpty;
    return ExpansionTile(
        visualDensity: VisualDensity.compact,
        enableFeedback: false,
        showTrailingIcon: true,
        title: Text(widget.canonicalLabel,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        subtitle: Text(
            isPathContentEmpty
                ? Provider.of<InternationalizationNotifier>(context, listen: false)
                    .i18n
                    .appGenerics
                    .empty
                : _pathContent,
            style: TextStyle(
                fontSize: 12,
                fontWeight: isPathContentEmpty ? FontWeight.w500 : FontWeight.normal,
                color: isPathContentEmpty ? kThemeNeedAction : kThemePrimaryFg2)),
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: TextFormField(
                    initialValue: _pathContent,
                    style: const TextStyle(fontSize: 14),
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    decoration: InputDecoration(hintText: widget.hintLabel),
                    onChanged: (String str) => setState(() => _pathContent = str),
                    validator: (String? value) {
                      if (value == null) {
                        return null;
                      }
                      if (_errnMsg != null) {
                        return _errnMsg;
                      }
                      widget
                          .validator(value)
                          .then((String? message) => setState(() => _errnMsg = message));
                    }),
              ),
            ),
            const SizedBox(width: 6),
            TextButton.icon(
                style: Theme.of(context).textButtonTheme.style!.copyWith(
                    visualDensity: VisualDensity.compact,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 0, horizontal: 6))),
                icon: const Icon(Ionicons.folder_outline),
                label: Text(widget.filePickerLabel, style: const TextStyle(fontSize: 14)),
                onPressed: () async {
                  FilePickerResult? res = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      dialogTitle: widget.filePickerDialogTitle,
                      type: widget.allowedExtensions.isEmpty
                          ? FileType.any
                          : FileType.custom,
                      allowedExtensions: widget.allowedExtensions);
                  if (res == null) {
                    logger.info("FilePicker#$hashCode ignored native_picker");
                  } else {
                    setState(() => _pathContent = res.files[0].path!);
                  }
                })
          ])
        ]);
  }
}
