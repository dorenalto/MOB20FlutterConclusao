import 'package:flutter/material.dart';

const brightness = Brightness.dark;

const primaryColor = const Color(0xFFFFCC00);
const lightColor = const Color(0xFFFFFFFF);
const backgroundColor = const Color(0xFFFFFFFF);
const accentColor = Colors.black26;

ThemeData darkYellowTheme() {
  return ThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
    accentColor: accentColor,
    primaryColorLight: lightColor,
  );
}
