import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';

abstract class JobForm {
  Future<void> buildJobFormUI(BuildContext context);
}

class JobCreationDialog extends StatelessWidget {
  final Widget child;
  final String jobName;

  const JobCreationDialog(
      {super.key, required this.child, required this.jobName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(kJobDispatcherFormScaffoldMargin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Create job instance of $jobName",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: kStylizedFontFamily,
                    fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: <Widget>[child]),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 6),
                TextButton(
                  onPressed: () {
                    // todo implement what happens after
                    Navigator.of(context).pop();
                  },
                  child: const Text("Schedule Job"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FilePickerButton extends StatelessWidget {
  const FilePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
            onPressed: () async {
              await FilePicker.platform.pickFiles(dialogTitle: "Pick file");
            }, // todo: incorporate with native file picker and fully implement this
            style: ButtonStyle(
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRRArc))),
                backgroundColor: const WidgetStatePropertyAll<Color>(kTheme1),
                foregroundColor: const WidgetStatePropertyAll<Color>(kThemeBg),
                visualDensity: VisualDensity.compact),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Ionicons.folder_outline,
                  size: 24,
                ),
                SizedBox(width: 4),
                Text("Use file picker", style: TextStyle(fontSize: 12))
              ],
            ))
        .animate()
        .fade(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut);
  }
}
