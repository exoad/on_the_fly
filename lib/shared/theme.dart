import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

// themes stuff
const Color kThemeBg = Colors.black;
const Color kThemeCmpBg = Color.fromARGB(140, 0, 0, 0);
const Color kThemePrimaryFg1 = Colors.white;
const Color kThemePrimaryFg2 = Color.fromARGB(255, 172, 172, 172);
const Color kThemePrimaryFg3 = Color.fromARGB(58, 172, 172, 172);
// opted components mostly only for things like expansion tiles
const Color kThemeOptedComponentFg = Color.fromARGB(255, 35, 35, 35);
const Color kThemeOptedComponentBorder = Color.fromARGB(255, 22, 22, 22);
const Color kTheme1 = Color.fromARGB(255, 255, 38, 103); // #ff2667
const Color kTheme2 = Color.fromARGB(255, 250, 185, 22); // #fab916
const Color kNull = Color.fromARGB(255, 255, 0, 220);
const Color kThemeNeedAction = Color.fromARGB(255, 255, 96, 78);

// /// this font is usually for like header texts and titles
// late final String kStylizedFontFamily = "Montserrat";
// removed this (thanks sean for the ui sugesstions)

/// default font used when the [kStylizedFontFamily] is not used
const String kDefaultFontFamily = "Montserrat";

/// global constant for the border radius arc used throughout the app
const double kRRArc = 6;

/// for bitsdojo_window
final WindowButtonColors kWindowButtonColors1 = WindowButtonColors(
    iconNormal: kThemePrimaryFg1,
    iconMouseDown: kTheme1,
    iconMouseOver: kTheme2,
    normal: Colors.transparent,
    mouseDown: Colors.transparent,
    mouseOver: Colors.transparent);

/// for bitsdojo_window
final WindowButtonColors kWindowButtonColors2 = WindowButtonColors(
    iconNormal: kThemePrimaryFg1,
    iconMouseDown: kTheme1,
    iconMouseOver: kTheme2,
    normal: Colors.transparent,
    mouseDown: Colors.transparent,
    mouseOver: Colors.transparent);

/// for bitsdojo_window
final WindowButtonColors kWindowButtonColors3 = WindowButtonColors(
    iconNormal: kThemePrimaryFg1,
    iconMouseDown: kTheme1,
    iconMouseOver: kTheme2,
    normal: Colors.transparent,
    mouseDown: Colors.transparent,
    mouseOver: Colors.transparent);
