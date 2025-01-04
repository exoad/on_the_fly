import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/debug_layer_view.dart';
import 'package:on_the_fly/client/events/debug_events.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/client/events/job_stack.dart';
import 'package:on_the_fly/client/left_menu_view.dart';
import 'package:on_the_fly/client/right_menu_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';
import "package:on_the_fly/shared/theme.dart";
import 'package:provider/provider.dart';

/// main interface of the app where all of the actions takes place :)
class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ListenableProvider<dynamic>>[
        ChangeNotifierProvider<GlobalJobStack>(create: (_) => GlobalJobStack()),
        if (kShowDebugView)
          ChangeNotifierProvider<DebugLayerEvents>(create: (_) => DebugLayerEvents())
      ],
      child: const _AppViewContainer(),
    );
  }
}

class _AppViewContainer extends StatelessWidget {
  const _AppViewContainer();

  static final ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
      style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc))),
          backgroundColor: const WidgetStatePropertyAll<Color>(kThemeBg),
          foregroundColor: const WidgetStatePropertyAll<Color>(kThemePrimaryFg1)));
  static final TooltipThemeData tooltipThemeData = TooltipThemeData(
      textStyle: const TextStyle(color: kThemePrimaryFg1),
      preferBelow: false,
      waitDuration: const Duration(milliseconds: 1000),
      exitDuration: const Duration(milliseconds: 750),
      decoration: BoxDecoration(
          color: kThemeBg,
          border: Border.all(color: kThemePrimaryFg1, width: 1.5),
          borderRadius: BorderRadius.circular(kRRArc)));
  static final OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
      style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStatePropertyAll<Color>(kThemePrimaryFg2.withAlpha(40)),
          iconColor: const WidgetStatePropertyAll<Color>(kThemePrimaryFg1),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRRArc),
              side: const BorderSide(color: kThemePrimaryFg1, width: 2))),
          foregroundColor: const WidgetStatePropertyAll<Color>(kThemePrimaryFg1),
          side: const WidgetStatePropertyAll<BorderSide>(
              BorderSide(color: kThemePrimaryFg1, width: 1))));
  static final TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll<Color>(
              kThemePrimaryFg1..withAlpha((255 * 0.3).round())),
          overlayColor: WidgetStatePropertyAll<Color>(kThemeBg.withAlpha(34)),
          iconColor: const WidgetStatePropertyAll<Color>(kThemeBg),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc))),
          splashFactory: NoSplash.splashFactory,
          backgroundColor: const WidgetStatePropertyAll<Color>(kThemePrimaryFg1),
          foregroundColor: const WidgetStatePropertyAll<Color>(kThemeBg)));
  static final TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
      selectionHandleColor: kThemePrimaryFg1,
      selectionColor: kThemePrimaryFg1.withAlpha((255 * 0.5).round()),
      cursorColor: kThemePrimaryFg1);
  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle:
        TextStyle(fontSize: 14, color: kThemePrimaryFg1, fontWeight: FontWeight.bold),
    hintStyle: TextStyle(fontSize: 12, color: kThemePrimaryFg2),
    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelStyle:
        TextStyle(fontSize: 12, color: kThemePrimaryFg1, fontWeight: FontWeight.bold),
    isDense: true,
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kThemePrimaryFg1)),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: kThemePrimaryFg3)),
    border: UnderlineInputBorder(borderSide: BorderSide(color: kThemePrimaryFg3)),
    activeIndicatorBorder: BorderSide(color: kThemePrimaryFg3),
  );
  static final ExpansionTileThemeData expansionTileThemeData = ExpansionTileThemeData(
      expansionAnimationStyle: AnimationStyle(curve: Curves.easeInExpo),
      backgroundColor: kThemeOptedComponentFg,
      iconColor: kThemePrimaryFg1,
      collapsedIconColor: kTheme1,
      childrenPadding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 6),
      collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRRArc),
          side: const BorderSide(color: kThemeOptedComponentFg, width: 1.5)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRRArc),
          side: const BorderSide(color: kThemeOptedComponentBorder, width: 1.5)));

  @override
  Widget build(BuildContext context) {
    // if we dont refactor and redfine these as separate variables, `dart format` fucks up
    // the formatting and makes a big mess (like the formatter just gives up formatting lol)

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "AutoImg",
          locale: Locale(
              Provider.of<InternationalizationNotifier>(context).i18n.languageCode),
          theme: ThemeData(
              cardColor: kThemeBg,
              secondaryHeaderColor: kThemePrimaryFg1,
              filledButtonTheme: const FilledButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(kTheme1),
                      iconColor: WidgetStatePropertyAll<Color>(kThemeBg),
                      foregroundColor: WidgetStatePropertyAll<Color>(kThemeBg),
                      textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: kThemeBg,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))),
              listTileTheme: ListTileThemeData(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc)),
                  subtitleTextStyle: const TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: kThemePrimaryFg2,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  titleTextStyle: const TextStyle(
                      color: kThemePrimaryFg1, fontSize: 20, fontWeight: FontWeight.bold),
                  enableFeedback: false,
                  selectedColor: kTheme1,
                  tileColor: const Color.fromRGBO(172, 172, 172, 0.22),
                  visualDensity: VisualDensity.comfortable),
              dividerColor: Colors.transparent,
              dividerTheme: const DividerThemeData(
                  space: 0, thickness: 0, color: Colors.transparent),
              drawerTheme: DrawerThemeData(
                  backgroundColor: kThemeBg,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc)),
                  clipBehavior: Clip.antiAlias),
              expansionTileTheme: expansionTileThemeData,
              splashColor: kThemePrimaryFg1.withAlpha((255 * 0.5).round()),
              buttonTheme: const ButtonThemeData(padding: EdgeInsets.zero),
              iconButtonTheme: IconButtonThemeData(
                  style: ButtonStyle(
                      splashFactory: InkRipple.splashFactory,
                      visualDensity: VisualDensity.compact,
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRRArc),
                      )),
                      iconColor: const WidgetStatePropertyAll<Color>(kThemeBg),
                      backgroundColor:
                          const WidgetStatePropertyAll<Color>(kThemePrimaryFg1),
                      overlayColor:
                          WidgetStatePropertyAll<Color>(kThemePrimaryFg1.withAlpha(45)))),
              elevatedButtonTheme: elevatedButtonThemeData,
              tooltipTheme: tooltipThemeData,
              outlinedButtonTheme: outlinedButtonThemeData,
              textButtonTheme: textButtonThemeData,
              dialogTheme: DialogTheme(
                clipBehavior: Clip.antiAlias,
                backgroundColor: kThemeBg,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRRArc),
                    side: const BorderSide(color: kThemePrimaryFg1, width: 2)),
              ),
              indicatorColor: kThemePrimaryFg1,
              iconTheme: const IconThemeData(color: kThemePrimaryFg1),
              scaffoldBackgroundColor: kThemeBg,
              textSelectionTheme: textSelectionThemeData,
              inputDecorationTheme: inputDecorationTheme,
              scrollbarTheme: const ScrollbarThemeData(
                  thumbColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                  radius: Radius.circular(kRRArc)),
              appBarTheme: const AppBarTheme(
                  surfaceTintColor: kThemeBg,
                  backgroundColor: kThemeBg,
                  foregroundColor: kThemePrimaryFg1,
                  titleTextStyle: TextStyle(
                      color: kThemePrimaryFg1,
                      fontSize: 24,
                      fontFamily: kDefaultFontFamily)),
              fontFamily: kDefaultFontFamily,
              brightness: Brightness.dark,
              primaryColor: kThemePrimaryFg1),
          home: Scaffold(
            body: WindowBorder(
              color: kThemeBg,
              width: 1,
              child: const Row(children: <Widget>[
                AppLeftMenuView(),
                AppRightMenuView(),
              ]),
            ),
          ),
        ),
        if (kShowDebugView) const DebugOverlayLayer()
      ],
    );
  }
}

// for bitsdojo_window package extension
enum WindowButtonType {
  MINIMIZE,
  MAXIMIZE_RESTORE,
  CLOSE,
}

class CustomWindowButton extends StatelessWidget {
  final void Function() action;
  final Color color;
  final IconData icon;

  CustomWindowButton({super.key, required WindowButtonType type, this.color = kTheme1})
      : action = switch (type) {
          // i love pattern matching :D
          WindowButtonType.MINIMIZE => appWindow.minimize,
          WindowButtonType.MAXIMIZE_RESTORE => appWindow.maximizeOrRestore,
          WindowButtonType.CLOSE => appWindow.close
        },
        icon = switch (type) {
          // i love pattern matching :D
          WindowButtonType.MINIMIZE => Ionicons.remove_circle,
          WindowButtonType.MAXIMIZE_RESTORE => Ionicons.scan_circle,
          WindowButtonType.CLOSE => Ionicons.close_circle
        };

  @override
  Widget build(BuildContext context) {
    return IconButton(
        constraints: const BoxConstraints.expand(width: 24, height: 24),
        style: const ButtonStyle(
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
            visualDensity: VisualDensity.compact,
            shape: WidgetStatePropertyAll<CircleBorder>(CircleBorder()),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)),
        onPressed: action,
        icon: Icon(icon, color: color));
  }
}

class AppWindowTitleButtons extends StatelessWidget {
  const AppWindowTitleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(spacing: 2, children: <Widget>[
        Tooltip(
            message: Provider.of<InternationalizationNotifier>(context)
                .i18n
                .appGenerics
                .minimize,
            child: CustomWindowButton(
                type: WindowButtonType.MINIMIZE, color: kThemePrimaryFg1)),
        Tooltip(
            message: Provider.of<InternationalizationNotifier>(context)
                .i18n
                .appGenerics
                .maximize,
            child: CustomWindowButton(
                type: WindowButtonType.MAXIMIZE_RESTORE, color: kTheme2)),
        Tooltip(
            message:
                Provider.of<InternationalizationNotifier>(context).i18n.appGenerics.close,
            child: CustomWindowButton(type: WindowButtonType.CLOSE, color: kTheme1))
      ]),
    );
  }
}
