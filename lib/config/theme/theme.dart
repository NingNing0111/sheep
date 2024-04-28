import 'package:flutter/material.dart';
import 'package:sheep/config/theme/text_color_schemes.dart';

import 'color_schemes.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      colorScheme: lightColorScheme,
      cardColor: Colors.pink[100],
      textTheme: lightTextColorSchemes);

  static ThemeData dark = ThemeData(
      colorScheme: darkColorScheme,
      cardColor: Colors.white10,
      textTheme: darkTextColorSchemes);
}
