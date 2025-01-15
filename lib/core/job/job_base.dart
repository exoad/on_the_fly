import 'package:flutter/material.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/helpers/i18n.dart';

class Job extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class JobAdvert {
  final LocaleProducer title;
  final LocaleProducer description;
  final List<FormatMedium> supportedMediums;

  const JobAdvert(
      {required this.title, required this.description, required this.supportedMediums});

  @override
  String toString() => "${title.value}:${description.value}:$supportedMediums";
}
