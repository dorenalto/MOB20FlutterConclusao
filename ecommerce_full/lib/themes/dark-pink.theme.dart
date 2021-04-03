import 'package:flutter/material.dart';

const brightness = Brightness.dark;
const primaryColor = const Color(0xFFE91E63);
const lightColor = const Color(0xFFFFFFFF);
const backgroundColor = const Color(0xFFFFFFFF);
const accentColor = Colors.black26;

ThemeData darkPinkTheme() {
  return ThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
    accentColor: accentColor,
  );
}
