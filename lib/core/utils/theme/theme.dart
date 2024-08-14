import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromRGBO(27, 27, 27, 1),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(48, 48, 48, 1), elevation: 0),
  );
}
