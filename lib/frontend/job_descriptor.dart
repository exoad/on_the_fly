import 'package:flutter/material.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/frontend/events/job_stack.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/layout.dart';

class JobDispatcherDescriptorView extends StatelessWidget {
  final Widget child;
  final JobDispatcher dispatcher;

  const JobDispatcherDescriptorView(
      {super.key, required this.child, required this.dispatcher});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          
        },
        child: child);
  }
}
