import 'package:flutter/material.dart';
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

  final List<dynamic> _jobStack = <dynamic>[];

  List<dynamic> get jobStack => _jobStack;

  void addJob(dynamic job) {
    if (kAllowDebugLogs) {
      logger.info("GlobalJobStack adds: $job");
    }
    debugSeek()["global_job_stack"] = _jobStack.toString();
    _jobStack.add(job);
    notifyListeners();
  }

  void removeJob(dynamic job) {
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
}
