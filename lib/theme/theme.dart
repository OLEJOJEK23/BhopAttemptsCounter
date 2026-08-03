import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const _accent = Color(0xFF378ADD);
  static const _accentDark = Color(0xFF85B7EB);

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: _accent,
      onPrimary: Colors.white,
      secondary: _accent,
      onSecondary: Colors.white,
      error: Color(0xFFE24B4A),
      onError: Colors.white,
      surface: Color(0xFFFAFAF8),
      onSurface: Color(0xFF1C1C1A),
      surfaceContainerHighest: Color(0xFFEDEDE9),
      onSurfaceVariant: Color(0xFF5F5E5A),
      outline: Color(0xFFD3D1C7),
      outlineVariant: Color(0xFFE3E2DC),
      primaryContainer: Color(0xFFE6F1FB),
      onPrimaryContainer: Color(0xFF0C447C),
      inverseSurface: Color(0xFF2C2C2A),
      onInverseSurface: Colors.white,
    );

    return _buildTheme(scheme);
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: _accentDark,
      onPrimary: Color(0xFF042C53),
      secondary: _accentDark,
      onSecondary: Color(0xFF042C53),
      error: Color(0xFFF09595),
      onError: Color(0xFF501313),
      surface: Color(0xFF19191B),
      onSurface: Color(0xFFECECE8),
      surfaceContainerHighest: Color(0xFF2A2A2C),
      onSurfaceVariant: Color(0xFFB4B2A9),
      outline: Color(0xFF444441),
      outlineVariant: Color(0xFF34343200),
      primaryContainer: Color(0xFF0C447C),
      onPrimaryContainer: Color(0xFFE6F1FB),
      inverseSurface: Color(0xFFECECE8),
      onInverseSurface: Color(0xFF2C2C2A),
    );

    return _buildTheme(scheme);
  }

  static ThemeData _buildTheme(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: 'Inter',
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant, width: 0.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 0.5,
        space: 0.5,
      ),
      textTheme:
          (isDark ? ThemeData.dark() : ThemeData.light()).textTheme.apply(
                bodyColor: scheme.onSurface,
                displayColor: scheme.onSurface,
              ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline, width: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
