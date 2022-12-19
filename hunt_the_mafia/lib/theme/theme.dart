import 'package:flutter/material.dart';

import '../shared/shared.dart';

class MyTheme {
  static ThemeData lightTheme(ColorScheme? lightColorScheme) {
    ColorScheme scheme = lightColorScheme ??
        ColorScheme.fromSeed(
          seedColor: Const.baseColor,
        );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
    );
  }

  static ThemeData darkTheme(ColorScheme? darkColorScheme) {
    ColorScheme scheme = darkColorScheme ??
        ColorScheme.fromSeed(
          seedColor: Const.baseColor,
          brightness: Brightness.dark,
        );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
    );
  }
}
