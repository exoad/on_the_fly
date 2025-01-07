import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/components/asyncs.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/app.dart';

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
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: _errnMsg);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPathContentEmpty = _pathContent.isEmpty;
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
        Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.canonicalLabel,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
              ),
              // Text(
              //   isPathContentEmpty
              //       ? Provider.of<InternationalizationNotifier>(context, listen: false)
              //           .i18n
              //           .appGenerics
              //           .empty
              //       : paths.basename(_pathContent),
              //   softWrap: true,
              //   style: TextStyle(
              //     fontSize: 12,
              //     fontWeight: isPathContentEmpty ? FontWeight.w500 : FontWeight.normal,
              //     color: isPathContentEmpty ? kThemeNeedAction : kThemePrimaryFg2,
              //   ),
              // ),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 2, // Adjust the flex value as needed
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: AsyncTextFormField(
              validationDebounce: const Duration(milliseconds: 120),
              controller: _textEditingController,
              decoration: InputDecoration(hintText: widget.hintLabel),
              validator: FilePathValidators.validateFilePath,
            ),
          ),
        ),
        const SizedBox(width: 6), // Adds space between the text field and button
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            style: Theme.of(context).textButtonTheme.style!.copyWith(
                  visualDensity: VisualDensity.compact,
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(vertical: 0, horizontal: 6),
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
      ],
    );

    // ]);
  }
}
