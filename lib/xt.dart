import 'package:on_the_fly/frontend/events/ephemeral_stacks.dart';
import 'package:on_the_fly/frontend/events/job_stack.dart';

/// generic runners class for debugging functions
class XtRunners {
  XtRunners._();

  @pragma("vm:prefer-inline")
  static void fx1() {
    for (int i = 0; i < 12; i++) {
      GlobalJobStack().addJob("$i ---");
    }
  }

  @pragma("vm:prefer-inline")
  static void fx2() {
    GlobalJobStack().removeAll();
  }

  static void fx3(String locale) {
    InternationalizationNotifier().changeLocale(locale);
  }
}
