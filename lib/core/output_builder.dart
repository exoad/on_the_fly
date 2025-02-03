import 'dart:io';

import 'package:on_the_fly/shared/app.dart';
import 'package:stubble/stubble.dart';

final OutputPathBuilder builder = OutputPathBuilder();

String _acceptableFileName(String f) {
  return f.replaceAll(RegExp(r"[^-a-zA-Z0-9_.() ]+"), "");
}

final class OutputPathBuilder {
  final Stubble stubble;
  static const String _allowedLetters =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.";
  static const String _numbers = "0123456789";
  static final Map<String, String Function(List<dynamic> attr)> defaultMappers = Map<
      String,
      String Function(
          List<dynamic> attr)>.unmodifiable(<String, String Function(List<dynamic> attr)>{
    "time": (List<dynamic> _) {
      DateTime now = DateTime.now();
      return "${now.month}_${now.day}_${now.year}__${now.hour}_${now.second}";
    },
    "random_str": (List<dynamic> attr) {
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
  });
  static final Map<String, String> _mapper = <String, String>{};

  OutputPathBuilder() : stubble = Stubble();

  void init() {}

  static void loadObj(String k, String v) {
    _mapper[k] = v;
  }

  static void clean() {
    _mapper.clear();
  }
}
