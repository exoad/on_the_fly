import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_the_fly/i18n/translations.i18n.dart';
import 'package:on_the_fly/i18n/translations_zh.i18n.dart';
import 'package:on_the_fly/shared/app.dart';

/// ! currently this implementation cannot provide dynamic locale changing
class InternationalizationNotifier extends ChangeNotifier {
  static final InternationalizationNotifier _singleton =
      InternationalizationNotifier.internal();

  @protected
  InternationalizationNotifier.internal() : i18n = const Translations() {
    // changeLocale("zh");
    changeLocale(Platform.localeName);
  }

  /// produces a singleton instance
  factory InternationalizationNotifier() => _singleton;

  covariant Translations i18n;

  static Translations findLocaleModule([String? localeName]) {
    return switch (localeName ?? Platform.localeName) {
      (String r) when r.startsWith("zh") => const TranslationsZh(),
      _ => const Translations(), // default and unsupported
    };
  }

  void changeLocale(String localeName) {
    i18n = findLocaleModule(localeName);
    notifyListeners();
    if (kAllowDebugLogs) {
      logger.info("Locale set to: '$localeName' -> $i18n");
    }
  }
}