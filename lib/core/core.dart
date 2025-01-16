import 'package:on_the_fly/core/formats.dart';
import 'package:on_the_fly/core/formats/images_target.dart';
import 'package:on_the_fly/core/job/job_base.dart';
import 'package:on_the_fly/helpers/i18n.dart';
import 'package:on_the_fly/shared/app.dart';

export "formats.dart";
export "jobs.dart";
export "folder_watchdog.dart";

class ConversionService {
  ConversionService._();

  static late final Map<String, JobAdvert> adverts;

  static late final List<FormatMedium> mediums;
  static void init() {
    logger.finer("Loading ConversionService utils");
    mediums = <FormatMedium>[ImageMedium.I];
    adverts = <String, JobAdvert>{
      "net.exoad.single_file": JobAdvert(
          title: LocaleProducer.key("job style adverts.single_file_title"),
          description: LocaleProducer.key("job style adverts.single_file_description"),
          supportedMediums: mediums),
      "net.exoad.multiple_files": JobAdvert(
        title: LocaleProducer.key("job style adverts.multiple_files_title"),
        description: LocaleProducer.key("job style adverts.multiple_files_description"),
        supportedMediums: mediums,
      ),
      "net.exoad.watch_folder": JobAdvert(
          title: LocaleProducer.key("job style adverts.watch_folder_title"),
          description: LocaleProducer.key("job style adverts.watch_folder_description"),
          supportedMediums: mediums),
    };
    logger.finer("Done loading ConversionService utils\n$adverts\n$mediums");
  }
}
