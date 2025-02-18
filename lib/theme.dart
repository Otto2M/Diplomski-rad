import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';

final lightAppTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.lightBlue,
    primaryContainer: AppColors.darkBlue,
    secondary: AppColors.yellow,
    secondaryContainer: AppColors.lightBlue.withOpacity(0.2),
    surface: AppColors.backgroundLight,
    error: AppColors.errorLightRed,
    onPrimary: AppColors.white,
    onSecondary: AppColors.darkBlue,
    onSurface: AppColors.darkBlue,
    onError: AppColors.white,
    tertiary: AppColors.lightGrey,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBlue,
    foregroundColor: AppColors.backgroundLight,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.darkBlue),
    bodyLarge: TextStyle(color: AppColors.darkBlue),
    titleSmall: TextStyle(color: AppColors.lightRed),
    titleMedium: TextStyle(color: AppColors.darkBlue),
    titleLarge: TextStyle(color: AppColors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.yellow, // Dodamo crvenu za gumbe
      foregroundColor: AppColors.darkBlue, // Tekst na gumbima
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(137, 47, 121, 211),
    selectedItemColor: AppColors.white,
    unselectedItemColor: AppColors.yellow,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
);

final darkAppTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.primaryDark,
    primaryContainer: AppColors.accentDark,
    secondary: AppColors.secondaryDark,
    secondaryContainer: AppColors.primaryDark.withOpacity(0.8),
    surface: AppColors.accentDark,
    error: AppColors.errorDarkRed,
    onPrimary: AppColors.white,
    onSecondary: AppColors.accentDark,
    onSurface: AppColors.white,
    onError: AppColors.white,
    tertiary: AppColors.darkGrey,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryDark,
    foregroundColor: AppColors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.white),
    bodyLarge: TextStyle(color: AppColors.accentDark),
    titleSmall: TextStyle(color: AppColors.errorDarkRed),
    titleMedium: TextStyle(color: AppColors.accentDark),
    titleLarge: TextStyle(color: AppColors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondaryDark, // Dodamo crvenu za gumbe
      foregroundColor: AppColors.accentDark, // Tekst na gumbima
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(137, 47, 121, 211),
    selectedItemColor: AppColors.backgroundDark,
    unselectedItemColor: AppColors.yellow,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
);
