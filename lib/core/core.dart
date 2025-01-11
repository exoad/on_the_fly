import 'package:on_the_fly/core/job/job_base.dart';
import 'package:on_the_fly/helpers/i18n.dart';

export "e_files.dart";
export "jobs.dart";
export "output_builder.dart";
export "folder_watchdog.dart";

class ConversionService {
  ConversionService._();

  static final Map<String, JobAdvert> adverts = <String, JobAdvert>{
    "net.exoad.single_file": JobAdvert(
        title: LocaleProducer.key("job style adverts.single_file_title"),
        description: LocaleProducer.key("job style adverts.single_file_description"))
  };
}
