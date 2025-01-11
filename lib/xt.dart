// import 'package:on_the_fly/frontend/events/ephemeral_stacks.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import 'package:on_the_fly/client/components/components.dart';
import 'package:on_the_fly/client/events/job_stack.dart';
import 'package:on_the_fly/shared/app.dart';

/// generic runners class for debugging functions
class XtRunners {
  XtRunners._();

  static final Map<String, void Function()> xtRunnersExport =
      <String, void Function()>{
    "rmfj": fx2,
    // fx3,
    "hashs_r": fx4
  };

  static List<Widget> r() {
    List<Widget> p = <Widget>[];
    for (MapEntry<String, void Function()> x in xtRunnersExport.entries) {
      p.add(CompactTextButton(x.key, onPressed: x.value));
    }
    return p;
  }

  @pragma("vm:prefer-inline")
  static void fx2() {
    GlobalJobStack().removeAll();
  }

  // static void fx3(String locale) {
  //   InternationalizationNotifier().changeLocale(locale);
  // }

  static void fx4() {
    logger.info(
        "${ObjectId().hexString} - ${ObjectId.fromTimestamp(DateTime.now())}");
  }
}
