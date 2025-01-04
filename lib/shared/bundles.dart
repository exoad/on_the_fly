import 'dart:io';

import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
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

  static void parseConfigurations() {
    String localeCode = strings.xpath("//Locale[@code]").first.attributes[0].value;
    bool validLocale = kDefinedLocales.contains(localeCode);
    logger.info(
        "FOUND_ Locale;code = [${validLocale ? "O" : "X" /*OMG SQUID GAME REFERENCE ?????*/}] $localeCode");
    if (validLocale) {
      InternationalizationNotifier().changeLocale(localeCode);
    }
  }

  static const List<String> _kValidInitialWindowStates = <String>["tray", "gui"];

  static String? get initialWindowState {
    String windowState = strings.xpath("//InitialWindowState").first.innerText.toLowerCase();
    bool validState = false;
    for (String r in _kValidInitialWindowStates) {
      if (r == windowState.trim()) {
        validState = true;
        break;
      }
    }
    return validState ? windowState : null;
  }
}
