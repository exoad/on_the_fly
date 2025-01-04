import "package:bitsdojo_window/bitsdojo_window.dart";
import "package:on_the_fly/client/events/ephemeral_stacks.dart";
import "package:on_the_fly/shared/app.dart";
import "package:system_tray/system_tray.dart";

const String kTrayDefaultIconAssetPath = "assets/tray/icon.ico";

late final SystemTray _trayInstance;

Future<void> initSystemTray() async {
  _trayInstance = SystemTray();
  await _trayInstance.initSystemTray(
      title: InternationalizationNotifier().i18n.appGenerics.canonical_title,
      toolTip: InternationalizationNotifier().i18n.appGenerics.canonical_title,
      iconPath: kTrayDefaultIconAssetPath);
  Menu menu = Menu();
  await menu.buildFrom(<MenuItemBase>[
    MenuItemLabel(
        label: InternationalizationNotifier().i18n.appGenerics.exit,
        onClicked: (_) => appWindow.close()),
    MenuItemLabel(
        label: InternationalizationNotifier().i18n.appGenerics.open_editor,
        onClicked: (_) => appWindow.show()),
    MenuItemLabel(
        label: InternationalizationNotifier().i18n.appGenerics.hide_editor,
        onClicked: (_) => appWindow.hide())
  ]);
  await _trayInstance.setContextMenu(menu);
  if (kAllowDebugLogs) {
    logger.info("Initialized System Tray !");
  }
  _trayInstance.registerSystemTrayEventHandler((String eventName) async {
    if (kAllowDebugLogs) {
      logger.info("SystemTray_Event: $eventName");
    }
    switch (eventName) {
      case kSystemTrayEventClick:
        appWindow.show();
        break;
      case kSystemTrayEventRightClick:
        await _trayInstance.popUpContextMenu();
        break;
      default:
        break; // do nothing
    }
  });
}

set systemTrayTooltip(String tooltip) => _trayInstance.setToolTip(tooltip);

set systemTrayImage(String path) => _trayInstance.setImage(path);
