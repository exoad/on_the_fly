import 'package:auto_img/parts/components/text_basis.dart';
import 'package:auto_img/parts/left_menu_view.dart';
import 'package:auto_img/shared/layout.dart';
import 'package:flutter/material.dart';
import "package:auto_img/shared/theme.dart";

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AutoImg",
      theme: ThemeData(
          listTileTheme: const ListTileThemeData(
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
            activeIndicatorBorder:
                BorderSide(color: kThemePrimaryFg1),
            labelStyle: TextStyle(color: kThemePrimaryFg1),
          ),
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
        body: Padding(
          padding: const EdgeInsets.all(kTotalAppPadding),
          child: Row(children: <Widget>[
            const AppLeftMenuView(),
            Expanded(
              child: Column(
                children: <Widget>[
                  AppBar(
                    title: StylizedText("AutoImg"),
                  ),
                  Expanded(
                    child: Center(
                      child: StylizedText("Hello, World!"),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
