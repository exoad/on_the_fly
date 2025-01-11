import 'package:flutter/material.dart';
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

  const JobAdvert({required this.title, required this.description});
}
