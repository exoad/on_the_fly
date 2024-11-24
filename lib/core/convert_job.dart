import 'package:auto_img/core/e_files.dart';
import 'package:auto_img/core/utils/result.dart';
import 'package:auto_img/shared/app.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as paths;

typedef Status = ({JobStatus status, String message});

abstract class ConvertJob {
  final String canonicalTitle;
  final String canonicalSubtitle;
  final String canonicalDescription;
  final List<ImgFileTypes> supportedInputs;
  final List<ImgFileTypes> supportedOutputs;

  final Map<int, ConvertJobInstance> instances;

  ConvertJob(
      {required this.canonicalTitle,
      required this.canonicalSubtitle,
      required this.canonicalDescription,
      required this.supportedInputs,
      required this.supportedOutputs})
      : instances = <int, ConvertJobInstance>{};

  ConvertJobInstance get newInst;

  @nonVirtual
  Result<bool, String> isValidInputCandidate(
      FileCandidate candidate) {
    if (candidate.autoDetectFileType == null) {
      return Result<bool, String>.bad(
          false, "File type not supported or could not be detected");
    }
    if (!candidate.autoDetectFileType!.canRead) {
      return Result<bool, String>.bad(false,
          "File type ${candidate.autoDetectFileType} for ${candidate.inputPath} is NOT supported for reading."); // we shld have a way in the ui to handle this
    }
    if (!supportedInputs.contains(candidate.autoDetectFileType!)) {
      return Result<bool, String>.bad(false,
          "File type ${candidate.autoDetectFileType} for ${candidate.inputPath} is NOT supported for this job.");
    }
    return Result<bool, String>.good(true,
        "File is a valid input candidate"); // we always provide a message !
  }

  Map<JobRequiredFields, String /*The title of the field*/ >
      get requiredFields;
}

abstract class ConvertJobInstance {
  final int
      parentID; // refers to the index of the job in the list of registered jobs
  final bool isContinuous;
  final String inputPath;
  final OutputPathHandler outputNameBuilder;
  final List<ImgFileTypes> inputFileTypes;
  final ImgFileTypes outputFileType;

  ConvertJobInstance(
      {required this.parentID,
      required this.isContinuous,
      required this.inputPath,
      required this.outputNameBuilder,
      required this.inputFileTypes,
      required this.outputFileType});

  void optionalAction();
}

enum JobRequiredFields {
  inputPathSelector,
  singleFiletypeSelector,
  multiFiletypeSelector,
  outputNameBuilderSelector,
}

typedef OutputPathHandler = String Function(
    String inputPath, ImgFileTypes outputType);

final class OutputNameBuilder {
  static OutputPathHandler simpleRandomName(
      {String allowedChars =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_",
      required int len}) {
    return (String inputPath, ImgFileTypes outputType) {
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < len; i++) {
        buffer
            .write(allowedChars[random.nextInt(allowedChars.length)]);
      }
      return paths.join(paths.dirname(inputPath),
          "${buffer.toString()}.${outputType.validExtensions.first}");
    };
  }

  static OutputPathHandler simpleName({required String name}) {
    return (String inputPath, ImgFileTypes outputType) {
      return paths.join(paths.dirname(inputPath),
          "$name.${outputType.validExtensions.first}");
    };
  }

  static OutputPathHandler simplePrefix({required String prefix}) {
    return (String inputPath, ImgFileTypes outputType) {
      return paths.join(paths.dirname(inputPath),
          "$prefix${paths.basenameWithoutExtension(inputPath)}.${outputType.validExtensions.first}");
    };
  }
}

class FileCandidate {
  final String inputPath;
  final OutputPathHandler outputName;

  FileCandidate({required this.inputPath, required this.outputName});

  /// If [autoDetectFileType] returns null, then the file type is not supported and should be skipped or treated as an error.
  ImgFileTypes? get autoDetectFileType {
    for (ImgFileTypes type in ImgFileTypes.inputTypes) {
      if (type.validExtensions.contains(paths.extension(inputPath))) {
        return type;
      }
    }
    return null;
  }
}

enum JobStatus {
  completed,
  failed,
  skipped;
}
