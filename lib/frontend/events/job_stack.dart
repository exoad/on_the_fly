import 'package:flutter/material.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/shared/app.dart';

// * NOT FINAL IMPL
/// represents the total stack of jobs within the app
///
/// should be used throughout the app
class GlobalJobStack with ChangeNotifier {
  final List<JobDispatcher<FileFormat>> _jobStack =
      <JobDispatcher<FileFormat>>[];

  List<JobDispatcher<FileFormat>> get jobStack => _jobStack;

  void addJob(JobDispatcher<FileFormat> job) {
    if (kAllowDebugLogs) {
      logger.info("GlobalJobStack adds: $job");
    }
    _jobStack.add(job);
    notifyListeners();
  }

  void removeJob(JobDispatcher<FileFormat> job) {
    if (kAllowDebugLogs) {
      logger.info("GlobalJobStack removes: $job");
    }
    _jobStack.remove(job);
    notifyListeners();
  }
}
