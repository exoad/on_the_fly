import 'dart:io';
import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:stubble/stubble.dart';

String _acceptableFileName(String f) {
  return f.replaceAll(RegExp(r"[^-a-zA-Z0-9_.() ]+"), "");
}

final class OutputPathBuilder {
  static final OutputPathBuilder defaultInstance = OutputPathBuilder();
  final Stubble stubble;
  static const String _allowedLetters =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.";
  static const String _numbers = "0123456789";
  static final Map<String, String Function(List<dynamic> attr)> defaultMappers =
      <String, String Function(List<dynamic> attr)>{
    "time": (List<dynamic> _) {
      DateTime now = DateTime.now();
      return "${now.month}_${now.day}_${now.year}__${now.hour}_${now.minute.toString().padLeft(2, '0')}_${now.second.toString().padLeft(2, '0')}";
    },
    "random_string": (List<dynamic> attr) {
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < attr[0]; i++) {
        buffer.write(_allowedLetters[random.nextInt(_allowedLetters.length)]);
      }
      return buffer.toString();
    },
    "os_name": (List<dynamic> _) {
      return _acceptableFileName(Platform.operatingSystem);
    },
    "random_num": (List<dynamic> attr) {
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < attr[0]; i++) {
        buffer.write(_numbers[random.nextInt(_numbers.length)]);
      }
      return buffer.toString();
    }
  };
  static final Map<String, String> _mapper = <String, String>{};

  Map<String, ({String description, Color color})> mapperDescriptions =
      <String, ({String description, Color color})>{
    "extension": (
      description:
          "The file extension of the output file. (Note: The file extension is not automatically appended!)",
      color: const Color.fromARGB(255, 98, 179, 245)
    ),
    "medium": (
      description:
          "The format category to which this conversion job belongs. Examples include 'IMAGE,' 'AUDIO,' and 'VIDEO.' These values are localized based on the selected language.",
      color: const Color.fromARGB(255, 255, 183, 74)
    ),
    "original_name": (
      description:
          "The name of the input file without the file extension and without the parent directories.",
      color: const Color.fromARGB(255, 158, 222, 85)
    ),
    "original_size": (
      description:
          "The size in kilobytes of the original input file (if this value cannot be found, defaults to '0')",
      color: const Color.fromARGB(255, 255, 113, 103)
    )
  };

  OutputPathBuilder() : stubble = Stubble();

  void init() {
    for (String k in mapperDescriptions.keys) {
      _mapper[k] = "";
    }
    logger.info("Initialized ${_mapper.length} entries into mapper. Ready");
  }

  void putObj(String k, String v) {
    if (!_mapper.containsKey(k)) {
      throw "Unused template key $k, which is not present in Mapper!";
    }
    _mapper[k] = v;
  }

  /// doesnt do any checks and force pushes any unknown or known key+value in contrast to [putObj]
  void forcePutObj(String k, String v, {String description = "???", Color? color}) {
    color ??= const Color.fromARGB(255, 228, 140, 255);
    _mapper[k] = v;
    mapperDescriptions[k] = (description: description, color: color);
  }

  String _process(String raw) {
    for (MapEntry<String, String Function(List<dynamic> attrs)> entry
        in defaultMappers.entries) {
      stubble.registerHelper(entry.key, (List<dynamic> attrs, Function? fn) {
        return entry.value(attrs);
      });
    }
    return stubble.compile(raw)(_mapper.isNotEmpty ? _mapper : <dynamic, dynamic>{});
  }

  String process(String raw, [bool dontPanic = true]) {
    try {
      return _process(raw);
    } catch (e) {
      if (e is Exception && !dontPanic && e.toString().endsWith("is unregistered")) {
        rethrow;
      } else {
        return "???";
      }
    }
  }

  void clean({bool deleteForeign = true}) {
    if (deleteForeign) {
      for (String k in List<String>.from(_mapper.keys)) {
        mapperDescriptions.containsKey(k) ? _mapper[k] = "" : _mapper.remove(k);
      }
    } else {
      _mapper.updateAll((String key, String value) => "");
    }
    stubble.dropHelpers();
  }

  bool containsKey(String k) {
    return _mapper.containsKey(k);
  }

  bool containsForeignObjs() {
    for (String k in _mapper.keys) {
      if (!mapperDescriptions.containsKey(k)) {
        return true;
      }
    }
    return false;
  }
}
