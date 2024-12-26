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

  /// removes a job instance via the [hashId] built into each
  /// job instance object. internally calls [getJobbyId]
  ///
  /// returns `true` if the job instance with the supplied `id` was found,
  /// otherwise `false` is returned that it wasn't found.
  ///
  /// may not be the most efficient option
  bool removeJobByID(String id) {
    Job? job = getJobById(id);
    if (job != null) {
      removeJob(job);
      return true;
    }
    return false;
  }

  void removeAll() /*volatile*/ {
    while (jobStack.isNotEmpty) {
      removeJob(jobStack.last);
    }
  }

  /// returns a job instance within the job stack using the [hashId] present.
  ///
  /// a `null` instance is returned if no jobs with the associated `id` could
  /// be found.
  ///
  /// may not be the most efficient option
  Job? getJobById(String id) {
    for (Job r in _jobStack) {
      if (r.hashId == id) {
        return r;
      }
    }
    return null;
  }

  Job operator [](int index) {
    return _jobStack[index];
  }
}
