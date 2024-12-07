import 'package:on_the_fly/parts/debug_layer_view.dart';
import 'package:on_the_fly/parts/events/debug_events.dart';
import 'package:on_the_fly/parts/events/job_stack.dart';
import 'package:on_the_fly/parts/left_menu_view.dart';
import 'package:on_the_fly/parts/right_menu_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';
import "package:on_the_fly/shared/theme.dart";
import 'package:provider/provider.dart';

/// main interface of the app where all of the actions takes place :)
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ListenableProvider<dynamic>>[
        ChangeNotifierProvider<GlobalJobStack>(create: (_) => GlobalJobStack()),
        if(kShowDebugView) ChangeNotifierProvider<DebugLayerEvents>(create: (_) => DebugLayerEvents())
      ],
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "AutoImg",
            theme: ThemeData(
                cardColor: kThemeBg,
                secondaryHeaderColor: kThemePrimaryFg1,
                filledButtonTheme: const FilledButtonThemeData(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(kTheme1),
                        iconColor: WidgetStatePropertyAll<Color>(kThemeBg),
                        foregroundColor:
                            WidgetStatePropertyAll<Color>(kThemeBg),
                        textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: kThemeBg,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)))),
                listTileTheme: const ListTileThemeData(
                    subtitleTextStyle: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        color: kThemePrimaryFg2,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    titleTextStyle: TextStyle(
                        fontFamily: kStylizedFontFamily,
                        color: kThemePrimaryFg1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enableFeedback: false,
                    selectedColor: kTheme1,
                    tileColor: Color.fromRGBO(172, 172, 172, 0.22),
                    visualDensity: VisualDensity.comfortable),
                dividerColor: Colors.transparent,
                dividerTheme: const DividerThemeData(
                    space: 0, thickness: 0, color: Colors.transparent),
                drawerTheme: DrawerThemeData(
                    backgroundColor: kThemeBg,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRRArc)),
                    clipBehavior: Clip.antiAlias),
                expansionTileTheme: ExpansionTileThemeData(
                    iconColor: kThemePrimaryFg1,
                    collapsedIconColor: kTheme1,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRRArc)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRRArc))),
                iconTheme: const IconThemeData(color: kThemePrimaryFg1),
                scaffoldBackgroundColor: kThemeBg,
                textSelectionTheme: TextSelectionThemeData(
                    selectionHandleColor: kThemePrimaryFg1,
                    selectionColor: kThemePrimaryFg1.withOpacity(0.5),
                    cursorColor: kThemePrimaryFg1),
                inputDecorationTheme: const InputDecorationTheme(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kThemePrimaryFg1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kThemePrimaryFg1),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kThemePrimaryFg1),
                  ),
                  activeIndicatorBorder: BorderSide(color: kThemePrimaryFg1),
                  labelStyle: TextStyle(color: kThemePrimaryFg1),
                ),
                scrollbarTheme: const ScrollbarThemeData(
                    thumbColor:
                        WidgetStatePropertyAll<Color>(Colors.transparent),
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
      ),
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
