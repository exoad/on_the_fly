import "package:bitsdojo_window/bitsdojo_window.dart";
import "package:on_the_fly/client/events/ephemeral_stacks.dart";
import "package:on_the_fly/shared/app.dart";
import "package:system_tray/system_tray.dart";

const String kTrayDefaultIconAssetPath = "assets/tray/icon.ico";

Future<void> initSystemTray() async {
  SystemTray tray = SystemTray();
  await tray.initSystemTray(
      title: InternationalizationNotifier().i18n.appGenerics.canonical_title,
      iconPath: kTrayDefaultIconAssetPath);
  Menu menu = Menu();
  await menu.buildFrom(<MenuItemBase>[
    MenuItemLabel(
        label: InternationalizationNotifier().i18n.appGenerics.exit,
        onClicked: (_) => appWindow.close())
  ]);
  await tray.setContextMenu(menu);
  if (kAllowDebugLogs) {
    logger.info("Initialized System Tray !");
  }
  tray.registerSystemTrayEventHandler((String eventName) async {
    if (kAllowDebugLogs) {
      logger.info("SystemTray_Event: $eventName");
    }
    switch (eventName) {
      case kSystemTrayEventClick:
        appWindow.show();
        break;
      case kSystemTrayEventRightClick:
        await tray.popUpContextMenu();
        break;
      default:
        break; // do nothing
    }
  });
}
