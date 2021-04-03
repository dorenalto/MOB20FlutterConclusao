import 'package:flutter/material.dart';

const brightness = Brightness.light;

const primaryColor = const Color(0xFF00C569);
const lightColor = const Color(0xFFFFFFFF);
const backgroundColor = const Color(0xFFF5F5F5);
const accentColor = Colors.black12;

ThemeData lightTheme() {
  return ThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
    accentColor: accentColor,
    scaffoldBackgroundColor: backgroundColor,
    primaryColorLight: lightColor,
  );
}
