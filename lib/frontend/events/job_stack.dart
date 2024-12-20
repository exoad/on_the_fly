import 'package:flutter/material.dart';
import 'package:on_the_fly/core/jobs.dart';
import 'package:on_the_fly/frontend/events/debug_events.dart';
import 'package:on_the_fly/shared/app.dart';

// * NOT FINAL IMPL
/// represents the total stack of jobs within the app
///
/// should be used throughout the app
class GlobalJobStack with ChangeNotifier {
  static final GlobalJobStack _instance = GlobalJobStack._();

  GlobalJobStack._();

  factory GlobalJobStack() => _instance;

  final List<Job> _jobStack = <Job>[];

  List<Job> get jobStack => _jobStack;

  void addJob(Job job) {
    if (kAllowDebugLogs) {
      logger.info("GlobalJobStack adds: $job");
    }
    _jobStack.add(job);
    debugSeek()["global_job_stack"] = _jobStack.toString();
    notifyListeners();
  }

  void removeJob(Job job) {
    if (kAllowDebugLogs) {
      logger.info("GlobalJobStack removes: $job");
    }
    _jobStack.remove(job);
    debugSeek()["global_job_stack"] = _jobStack.toString();
    notifyListeners();
  }

  void removeAll() /*volatile*/ {
    while (jobStack.isNotEmpty) {
      removeJob(jobStack.last);
    }
  }

  Job operator [](int index) {
    return _jobStack[index];
  }
}
