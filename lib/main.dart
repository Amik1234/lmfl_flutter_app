import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/app_colors.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const LMFLApp());
}

/// Главное приложение ЛМФЛ
/// Конвертировано из Android MainActivity.kt
class LMFLApp extends StatelessWidget {
  const LMFLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ЛМФЛ - Любительская мини-футбольная лига',
      debugShowCheckedModeBanner: false,
      
      // Темы приложения
      theme: ThemeData(
        colorScheme: AppColors.lightColorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 4,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.bottomNavBackground,
          selectedItemColor: AppColors.bottomNavSelected,
          unselectedItemColor: AppColors.bottomNavUnselected,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.textOnPrimary,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      
      darkTheme: ThemeData(
        colorScheme: AppColors.darkColorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 4,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}
