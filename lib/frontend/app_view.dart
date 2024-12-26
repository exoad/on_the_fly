import 'package:on_the_fly/frontend/debug_layer_view.dart';
import 'package:on_the_fly/frontend/events/debug_events.dart';
import 'package:on_the_fly/frontend/events/ephemeral_stacks.dart';
import 'package:on_the_fly/frontend/events/job_stack.dart';
import 'package:on_the_fly/frontend/left_menu_view.dart';
import 'package:on_the_fly/frontend/right_menu_view.dart';
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
    return ChangeNotifierProvider<InternationalizationNotifier>(
      lazy: true,
      create: (_) => InternationalizationNotifier(),
      child: MultiProvider(
        providers: <ListenableProvider<dynamic>>[
          ChangeNotifierProvider<GlobalJobStack>(create: (_) => GlobalJobStack()),
          if (kShowDebugView)
            ChangeNotifierProvider<DebugLayerEvents>(create: (_) => DebugLayerEvents())
        ],
        child: const _AppViewContainer(),
      ),
    );
  }
}

class _AppViewContainer extends StatelessWidget {
  const _AppViewContainer();

  @override
  Widget build(BuildContext context) {
    // if we dont refactor and redfine these as separate variables, `dart format` fucks up
    // the formatting and makes a big mess (like the formatter just gives up formatting lol)
    ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
        style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc))),
            backgroundColor: const WidgetStatePropertyAll<Color>(kThemeBg),
            foregroundColor: const WidgetStatePropertyAll<Color>(kThemePrimaryFg1)));
    TooltipThemeData tooltipThemeData = TooltipThemeData(
        textStyle: const TextStyle(color: kThemePrimaryFg1),
        preferBelow: false,
        waitDuration: const Duration(milliseconds: 1000),
        exitDuration: const Duration(milliseconds: 750),
        decoration: BoxDecoration(
            color: kThemeBg,
            border: Border.all(color: kThemePrimaryFg1, width: 1.5),
            borderRadius: BorderRadius.circular(kRRArc)));
    OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
        style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStatePropertyAll<Color>(kThemePrimaryFg2.withAlpha(40)),
            iconColor: const WidgetStatePropertyAll<Color>(kThemePrimaryFg1),
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRRArc),
                side: const BorderSide(color: kThemePrimaryFg1, width: 1.5))),
            foregroundColor: const WidgetStatePropertyAll<Color>(kThemePrimaryFg1),
            side: const WidgetStatePropertyAll<BorderSide>(
                BorderSide(color: kThemePrimaryFg1, width: 1))));
    TextButtonThemeData textButtonThemeData = TextButtonThemeData(
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
    TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
        selectionHandleColor: kThemePrimaryFg1,
        selectionColor: kThemePrimaryFg1.withAlpha((255 * 0.5).round()),
        cursorColor: kThemePrimaryFg1);
    InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      labelStyle: const TextStyle(
          fontSize: 14, color: kThemePrimaryFg1, fontWeight: FontWeight.bold),
      hintStyle: const TextStyle(fontSize: 12, color: kThemePrimaryFg2),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelStyle: const TextStyle(
          fontSize: 12, color: kThemePrimaryFg1, fontWeight: FontWeight.bold),
      isDense: true,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kThemePrimaryFg1),
          borderRadius: BorderRadius.circular(kRRArc)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kThemePrimaryFg2.withAlpha(120)),
          borderRadius: BorderRadius.circular(kRRArc)),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: kThemePrimaryFg2.withAlpha(120)),
          borderRadius: BorderRadius.circular(kRRArc)),
      activeIndicatorBorder: BorderSide(color: kThemePrimaryFg2.withAlpha(120)),
    );
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
              expansionTileTheme: ExpansionTileThemeData(
                  iconColor: kThemePrimaryFg1,
                  collapsedIconColor: kTheme1,
                  collapsedShape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRRArc))),
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

class AppWindowTitleButtons extends StatelessWidget {
  const AppWindowTitleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      MinimizeWindowButton(colors: kWindowButtonColors3),
      MaximizeWindowButton(colors: kWindowButtonColors2),
      CloseWindowButton(colors: kWindowButtonColors3)
    ]);
  }
}
