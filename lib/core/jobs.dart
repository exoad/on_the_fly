import 'package:meta/meta.dart';
import 'package:on_the_fly/core/e_files.dart';
import 'package:on_the_fly/core/utils/form_ui_transfer.dart';
import 'package:on_the_fly/shared/app.dart';

abstract class JobInstance<E extends FileFormat> {
  final Jobs<E> parent;

  JobInstance({
    required this.parent,
  });
}

/// a basis for all jobs
///
/// [E] represents the type (usually an enum) that can be used to represent the type of the input/output file types.
abstract class Jobs<E extends FileFormat> {
  final String name;
  final String description;

  final OrderForm _orderForm;

  /// represents the accepted input types
  final List<E> inputTypes;

  /// represents the output types
  final List<E> outputTypes;
  final String mediumName;

  static Map<String, List<Jobs<FileFormat>>> registeredJobs =
      <String, List<Jobs<FileFormat>>>{};

  static List<Jobs<FileFormat>> getJobsByMedium(String mediumName) {
    if (!registeredJobs.containsKey(mediumName) && kAllowDebugWarnings) {
      throw ArgumentError(
          "Medium Key not found in registered jobs: $mediumName"); // another programmer error ! bruh
    }
    return registeredJobs[mediumName]!;
  }

  static Map<String, Iterable<Jobs<FileFormat>>> get getJobsByMediumMap =>
      registeredJobs;

  static void registerJob(Jobs<FileFormat> r) {
    if (!registeredJobs.containsKey(r.mediumName)) {
      registeredJobs[r.mediumName] = <Jobs<FileFormat>>[];
    }
    registeredJobs[r.mediumName]!.add(r);
    r._id = registeredJobs.length - 1;
  }

  late int _id;

  int get id => _id;

  @nonVirtual
  OrderForm get orderForm => _orderForm;

  Jobs(
      {required this.name,
      required this.description,
      required this.inputTypes,
      required this.outputTypes,
      required this.mediumName,
      required OrderForm orderForm})
      : _orderForm = orderForm {
    assert(inputTypes.isNotEmpty);
    assert(outputTypes.isNotEmpty);
  }

}

/// this represents a single convert job for a single image file
class SingleImgJob extends Jobs<FileFormat> {
  SingleImgJob()
      : super(
            name: "Single Image",
            mediumName: ImageMedium.inst.mediumName,
            description:
                "Converts a single image file from one format to another",
            inputTypes: ImageMedium.inst.inputFormats,
            outputTypes: ImageMedium.inst.outputFormats,
            orderForm: OrderForm(
                title:
                    "Single Image Conversion #${Jobs.registeredJobs.length + 1}",
                onOrder: () {},
                isAlive: () => true,
                pumps: <String, UIPump<dynamic>>{
                  "in_file": StringInputPump(
                      label: "Input File",
                      pump: (String input) {},
                      validator: (String? input) => null),
                }));
}
