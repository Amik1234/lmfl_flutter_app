import 'package:flutter/material.dart';

/// Цветовая схема ЛМФЛ приложения
/// Конвертировано из Android проекта
class AppColors {
  // Основная цветовая палитра - современный градиент синего
  static const Color primaryColor = Color(0xFF1976D2);
  static const Color primaryDarkColor = Color(0xFF0D47A1);
  static const Color primaryLightColor = Color(0xFFBBDEFB);
  
  // Акцентные цвета - современный оранжевый
  static const Color accentColor = Color(0xFFFF5722);
  static const Color accentLightColor = Color(0xFFFFCCBC);
  
  // Цвета для нижней навигации
  static const Color bottomNavBackground = Color(0xFFFFFFFF);
  static const Color bottomNavSelected = Color(0xFF1976D2);
  static const Color bottomNavUnselected = Color(0xFF9E9E9E);
  
  // Цвета фона
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  
  // Текстовые цвета
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Системные цвета
  static const Color errorColor = Color(0xFFF44336);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  
  // Цвета для темной темы
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  
  // Создание материального цветового схемы
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    primary: primaryColor,
    secondary: accentColor,
    surface: surfaceColor,
    error: errorColor,
  );
  
  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
    primary: primaryColor,
    secondary: accentColor,
    surface: darkSurface,
    error: errorColor,
  );
}