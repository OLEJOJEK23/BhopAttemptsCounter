import 'package:flutter/material.dart';

/// Простой менеджер тем, использующий ValueNotifier.
/// Он реализован как Singleton, чтобы к нему был доступ из любого места в приложении.
class ThemeManager extends ValueNotifier<ThemeMode> {
  // Приватный конструктор
  ThemeManager._() : super(ThemeMode.system);

  // Единственный экземпляр класса
  static final ThemeManager instance = ThemeManager._();

  /// Переключает тему между светлой и темной.
  void toggleTheme(bool isDarkMode) {
    value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}
