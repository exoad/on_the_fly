import 'package:auto_img/parts/left_menu_view.dart';
import 'package:auto_img/shared/layout.dart';
import 'package:flutter/material.dart';
import "package:auto_img/shared/theme.dart";
import 'package:flutter_svg/flutter_svg.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AutoImg",
      theme: ThemeData(
          cardColor: kThemeBg,
          secondaryHeaderColor: kThemePrimaryFg1,
          listTileTheme: const ListTileThemeData(
              enableFeedback: false,
              selectedColor: kTheme1,
              tileColor: kThemeBg,
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
        body: Padding(
          padding: const EdgeInsets.all(kTotalAppPadding),
          child: Row(children: <Widget>[
            Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kThemePrimaryFg1.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(kRRArc),
                    color: kThemeCmpBg),
                child: const AppLeftMenuView()),
            Expanded(
              child: Column(
                children: <Widget>[
                  AppBar(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: 250,
                            height: 200,
                            child: SvgPicture.asset(
                                "assets/illust/undraw_loading.svg",
                                height: 200)),
                        const SizedBox(height: 18),
                        const Text("No jobs, add one to start"),
                      ],
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
