import 'package:flutter/material.dart';

const brightness = Brightness.dark;

const primaryColor = const Color(0xFF00C569);
const lightColor = const Color(0xFFFFFFFF);
const backgroundColor = const Color(0xFFF5F5F5);
const accentColor = Colors.black26;

ThemeData darkTheme() {
  return ThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
    accentColor: accentColor,
    primaryColorLight: lightColor,
  );
}
