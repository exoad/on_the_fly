import 'dart:io';

import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/helpers/basics.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

/// this file just contaisn code for builtin config constants (this constants are adjustable by the user)
final class Bundles {
  Bundles._();
  static late final XmlDocument strings;
  static Future<void> loadAllBundles() async {
    // prepare strings bundle (AKA the configurations)
    logger.info("Preparing load strings bundle");
    String stringsRaw = await File("assets/strings_bundle.xml").readAsString();
    strings = XmlDocument.parse(stringsRaw);
    logger.info("Strings Bundle loaded ${stringsRaw.length} chars");
  }

  static bool? parseBool(String xPath) =>
      Bundles.strings
          .xpath(xPath)
          .first
          .innerText
          .toLowerCase()
          .replaceAll(RegExp(r"\s+"), "") ==
      "true";
}

final class PublicBundle {
  PublicBundle._();

  static final Map<String, dynamic> _values = <String, dynamic>{};

  static void parseConfigurations() {
    String localeCode = Bundles.strings
        .xpath("//RootBundle//Public//Locale[@code]")
        .first
        .attributes[0]
        .value;
    bool validLocale = kDefinedLocales.contains(localeCode);
    logger.info(
        "FOUND_ Locale;code = [${validLocale ? "O" : "X" /*OMG SQUID GAME REFERENCE ?????*/}] $localeCode");
    if (validLocale) {
      InternationalizationNotifier().changeLocale(localeCode);
    }
  }

  static const List<String> _kValidInitialWindowStates = <String>["tray", "gui"];

  static String? get initialWindowState {
    if (_values.containsKey("InitialWindowState")) {
      return _values["InitialWindowState"];
    }
    String windowState = Bundles.strings
        .xpath("//RootBundle//Public//InitialWindowState")
        .first
        .innerText
        .toLowerCase()
        .replaceAll(RegExp(r"\s+"), "");
    bool validState = false;
    for (String r in _kValidInitialWindowStates) {
      if (r == windowState) {
        validState = true;
        break;
      }
    }
    return validState ? windowState : null;
  }

  static bool get isMinimizeToTray => _values.getOrDefault("MinimizeToTray",
      Bundles.parseBool("//RootBundle//Public//MinimizeToTray") ?? true);

  static bool get isInitialFocused => _values.getOrDefault("InitialFocused",
      Bundles.parseBool("//RootBundle//Public//InitialFocused") ?? false);

  static bool get preferDenseActionables => _values.getOrDefault("PreferDenseActionables",
      Bundles.parseBool("//RootBundle//Public//PreferDenseActionables") ?? false);
}

// yea the names here are quite sus, but they make sense tho in terms of terminology
