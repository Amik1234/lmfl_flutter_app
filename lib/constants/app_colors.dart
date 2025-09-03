import 'package:flutter/material.dart';

/// Обновленная цветовая схема ЛМФЛ в футбольной тематике
/// Вдохновлена цветами футбольного поля и современными спортивными брендами
class AppColors {
  // Основная палитра - футбольная зелень и белый
  static const Color primaryColor = Color(0xFF2E7D32); // Темно-зеленый (цвет поля)
  static const Color primaryDarkColor = Color(0xFF1B5E20); // Очень темно-зеленый
  static const Color primaryLightColor = Color(0xFF4CAF50); // Светло-зеленый
  static const Color primarySurfaceColor = Color(0xFFE8F5E8); // Очень светло-зеленый
  
  // Акцентные цвета - оранжевый (цвет мяча)
  static const Color accentColor = Color(0xFFFF6F00); // Ярко-оранжевый
  static const Color accentLightColor = Color(0xFFFFB74D); // Светло-оранжевый
  static const Color accentDarkColor = Color(0xFFE65100); // Темно-оранжевый
  
  // Дополнительные спортивные цвета
  static const Color goldColor = Color(0xFFFFD700); // Золотой (для наград)
  static const Color silverColor = Color(0xFFC0C0C0); // Серебряный
  static const Color bronzeColor = Color(0xFFCD7F32); // Бронзовый
  
  // Цвета для нижней навигации
  static const Color bottomNavBackground = Color(0xFFFFFFFF);
  static const Color bottomNavSelected = Color(0xFF2E7D32);
  static const Color bottomNavUnselected = Color(0xFF757575);
  static const Color bottomNavIndicator = Color(0xFF4CAF50);
  
  // Цвета фона
  static const Color backgroundColor = Color(0xFFF1F8E9); // Очень светло-зеленый фон
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFE0E0E0);
  
  // Текстовые цвета
  static const Color textPrimary = Color(0xFF1B5E20); // Темно-зеленый для основного текста
  static const Color textSecondary = Color(0xFF388E3C); // Средне-зеленый для вторичного текста
  static const Color textTertiary = Color(0xFF757575); // Серый для третичного текста
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFFFFFFFF);
  
  // Системные цвета
  static const Color errorColor = Color(0xFFD32F2F); // Красный (красная карточка)
  static const Color successColor = Color(0xFF388E3C); // Зеленый (успех)
  static const Color warningColor = Color(0xFFFF6F00); // Оранжевый (предупреждение)
  static const Color infoColor = Color(0xFF1976D2); // Синий (информация)
  
  // Градиенты
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6F00), Color(0xFFFFB74D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Цвета для темной темы
  static const Color darkBackground = Color(0xFF0D1B0F); // Очень темно-зеленый
  static const Color darkSurface = Color(0xFF1B2E1D); // Темно-зеленый
  static const Color darkCardColor = Color(0xFF263228); // Средне-темно-зеленый
  static const Color darkTextPrimary = Color(0xFFE8F5E8);
  static const Color darkTextSecondary = Color(0xFFA5D6A7);
  
  // Создание материального цветового схемы
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    primary: primaryColor,
    secondary: accentColor,
    surface: surfaceColor,
    error: errorColor,
    onPrimary: textOnPrimary,
    onSecondary: textOnAccent,
    onSurface: textPrimary,
    tertiary: goldColor,
  );
  
  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
    primary: primaryLightColor,
    secondary: accentLightColor,
    surface: darkSurface,
    error: errorColor,
    onPrimary: darkTextPrimary,
    onSecondary: darkTextPrimary,
    onSurface: darkTextPrimary,
    tertiary: goldColor,
  );
  
  // Тени
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];
}