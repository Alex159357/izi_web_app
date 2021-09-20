import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: primarySwatch,
    accentColor: Color(0xFFFA6400),
    scaffoldBackgroundColor: Color(0xfff1f1f1),
    backgroundColor: Colors.white,
    primaryIconTheme: IconThemeData(color: Colors.white),
    accentIconTheme: IconThemeData(color: Color(0xFFFA6400)),
    primaryColor: Color(0xFFFA6400),
    textSelectionColor: Colors.black);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: primarySwatch,
    accentColor: Color(0xFFFA6400),
    backgroundColor: Colors.black12,
    textSelectionColor: Colors.blueGrey[50],
    // textTheme: GoogleFonts.poppinsTextTheme()
    //     .apply(bodyColor: Colors.white),
    // canvasColor: Color(0xFFFA6400)
);

const MaterialColor primarySwatch = const MaterialColor(
  0xffe55f48,
  // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  const <int, Color>{
    50: const Color(0xFFff8330), //10%
    100: const Color(0xFFFA6400), //20%
    200: const Color(0xFFde5900), //30%
    300: const Color(0xFFc45002), //40%
    400: const Color(0xFFab4500), //50%
    500: const Color(0xFF8c3901), //60%
    600: const Color(0xFF753001), //70%
    700: const Color(0xFF5e2702), //80%
    800: const Color(0xFF4a1e01), //90%
    900: const Color(0xFF331501), //100%
  },
);
