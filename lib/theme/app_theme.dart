import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color(0xFF4F7D6A); // my green
  static const _accent = Color(0xFFE8AC73); //  my orange

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light)
          .copyWith(secondary: _accent),
      fontFamily: 'Roboto',
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark)
          .copyWith(secondary: _accent),
      fontFamily: 'Roboto',
    );
  }
}
