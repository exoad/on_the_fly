import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/frontend/events/ephemeral_stacks.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

class JobPathPickerActionable extends StatefulWidget {
  final void Function(String str) onChanged;
  final String Function(String? str)? validator;
  final String canonicalLabel;
  final String hintLabel;
  final List<String> allowedExtensions;
  final String? filePickerDialogTitle;
  final String filePickerLabel;
  final bool filePickerAllowMultiple;

  const JobPathPickerActionable(
      {super.key,
      this.filePickerDialogTitle,
      required this.filePickerAllowMultiple,
      required this.onChanged,
      required this.allowedExtensions,
      this.validator,
      required this.canonicalLabel,
      this.hintLabel = ".../users/downloads/...",
      required this.filePickerLabel});

  @override
  State<JobPathPickerActionable> createState() => _JobPathPickerActionableState();
}

class _JobPathPickerActionableState extends State<JobPathPickerActionable> {
  String _pathContent = "";

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
                  style: const TextStyle(fontSize: 14),
                  autovalidateMode: AutovalidateMode.always,
                  autocorrect: false,
                  decoration: InputDecoration(hintText: widget.hintLabel),
                  onChanged: (String str) => setState(() => _pathContent = str),
                  validator: (String? str) {
                    return null;
                  },
                ),
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
                  await FilePicker.platform.pickFiles(
                      allowMultiple: widget.filePickerAllowMultiple,
                      dialogTitle: widget.filePickerDialogTitle,
                      type: widget.allowedExtensions.isEmpty
                          ? FileType.any
                          : FileType.custom,
                      allowedExtensions: widget.allowedExtensions);
                })
          ])
        ]);
  }
}
