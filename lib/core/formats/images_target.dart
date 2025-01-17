import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/helpers/i18n.dart';

/// represents the builtin image formats supported by on the fly
///
/// see [FormatMedium] for more indepth information
final class ImageMedium extends FormatMedium {
  static final ImageMedium I = ImageMedium._();

  ImageMedium._()
      : super(
            mediumName: LocaleProducer.key("format generic.image"),
            formats: <String, FileFormat>{
              "webp": const FileFormat(
                  canonicalName: "WebP",
                  canWrite: false,
                  canRead: true),
              "jpg": const FileFormat(
                  canonicalName: "JPEG",
                  canWrite: true,
                  canRead: true),
              "bmp": const FileFormat(
                  canonicalName: "BMP",
                  canWrite: true,
                  canRead: true),
              "ico": const FileFormat(
                  canonicalName: "ICO",
                  canWrite: true,
                  canRead: true),
              "png": const FileFormat(
                  canonicalName: "PNG",
                  canWrite: true,
                  canRead: true),
              "gif": const FileFormat(
                  canonicalName: "GIF",
                  canWrite: true,
                  canRead: true),
              "tiff": const FileFormat(
                  canonicalName: "TIFF",
                  canWrite: true,
                  canRead: true),
              "tga": const FileFormat(
                  canonicalName: "TGA",
                  canWrite: true,
                  canRead: true),
              "psd": const FileFormat(
                  canonicalName: "PSD",
                  canWrite: false,
                  canRead: true),
            });
}

// /// a job instance produced by the [SingleImgJobDispatcher] dispatcher
// class SingleImgJob extends Job {

//   SingleImgJob({required super.inputPath});

//   @override
//   bool canPop() {
//     return true;
//   }

//   @override
//   Result<Null, String> process() {
//     throw UnimplementedError();
//   }

//   @override
//   j.JobBody buildForm(BuildContext context) {
//     return j.JobBody(
//         onRemoveJob: () =>
//             Provider.of<GlobalJobStack>(context, listen: false).removeJob(this),
//         children: <Widget>[
//           j.JobTitle(
//               title: Provider.of<InternationalizationNotifier>(context)
//                   .i18n
//                   .singleImgJob
//                   .canonical_name,
//               subtitle: timestamp.canonicalizedTimeString,
//               hash: hashId),
//           j.JobSinglePathPickerActionable(
//               formatMedium: ImageMedium.I,
//               onChanged: (String str) {},
//               allowedExtensions: List<String>.empty(),
//               filePickerLabel:
//                   Provider.of<InternationalizationNotifier>(context, listen: false)
//                       .i18n
//                       .appGenerics
//                       .browse),
//           const SizedBox(height: 12),
//           j.JobBasicOutputPathBuilder(
//               chipIcon: const Icon(Ionicons.image),
//               formats: ImageMedium.I.outputFormats,
//               onDone: (_) {},
//               initialFolder: "Amogus")
//         ]);
//   }
// }

// class ImageRoutineProcessor extends RoutineProcessor<ImageMedium> {
//   @override
//   Future<Result<Null, String>> convert(RoutineOrder<ImageMedium> order) async {
//     throw UnimplementedError();
//   }

//   @override
//   String get canonicalName =>
//       InternationalizationNotifier().i18n.builtinImgProcessor.canonical_name;

//   @override
//   String get canonicalDescriptor =>
//       InternationalizationNotifier().i18n.builtinImgProcessor.proper_description;
// }
