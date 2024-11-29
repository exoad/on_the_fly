import 'package:flutter/material.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/shared/app.dart';

// * NOT FINAL IMPL
/// represents the total stack of jobs within the app
///
/// should be used throughout the app
class GlobalJobStack with ChangeNotifier {
  final List<Jobs<FileFormat>> _jobStack = <Jobs<FileFormat>>[];

  List<Jobs<FileFormat>> get jobStack => _jobStack;

  void addJob(Jobs<FileFormat> job) {
    if (kAllowDebugLogs) {
      logger.info("GlobalJobStack adds: $job");
    }
    _jobStack.add(job);
    notifyListeners();
  }

  void removeJob(Jobs<FileFormat> job) {
    if (kAllowDebugLogs) {
      logger.info("GlobalJobStack removes: $job");
    }
    _jobStack.remove(job);
    notifyListeners();
  }
}
