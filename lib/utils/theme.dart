import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      useMaterial3: true,
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      useMaterial3: true,
    );
  }
}
