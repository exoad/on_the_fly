extension BetterDateTime on DateTime {
  String get canonicalizedTimeString =>
      "$month-$day-$year $hour:$minute:$millisecond";
}
