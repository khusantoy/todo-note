import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        error: Colors.red,
        onTertiary: Colors.orange,
      ),
      textTheme: const TextTheme(
        displaySmall:  TextStyle(
          fontSize: 54,
          fontWeight: FontWeight.bold,
        )
      ),
      useMaterial3: true,
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      useMaterial3: true,
    );
  }
}
