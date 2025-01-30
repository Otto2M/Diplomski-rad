// import 'package:flutter/material.dart';
// //import 'package:google_fonts/google_fonts.dart';

// final appTheme = ThemeData(
//   colorScheme: const ColorScheme.light().copyWith(
//     brightness: Brightness.light,
//     surface: const Color.fromARGB(255, 119, 149, 175),
//     onSurface: const Color.fromARGB(255, 87, 29, 133),
//   ),
//   scaffoldBackgroundColor: const Color.fromARGB(255, 41, 53, 56),
//   //textTheme: GoogleFonts.latoTextTheme(),
// );

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
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightBlue,
    foregroundColor: AppColors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.darkBlue),
    bodyLarge: TextStyle(color: AppColors.darkBlue),
    titleSmall: TextStyle(color: AppColors.errorLightRed),
    titleMedium: TextStyle(color: AppColors.darkBlue),
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
);

final darkAppTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.primaryDark,
    primaryContainer: AppColors.accentDark,
    secondary: AppColors.secondaryDark,
    secondaryContainer: AppColors.primaryDark.withOpacity(0.2),
    surface: AppColors.backgroundDark,
    error: AppColors.errorDarkRed,
    onPrimary: AppColors.white,
    onSecondary: AppColors.black,
    onSurface: AppColors.white,
    onError: AppColors.white,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryDark,
    foregroundColor: AppColors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.white),
    bodyMedium: TextStyle(color: AppColors.white),
    titleLarge: TextStyle(color: AppColors.secondaryDark),
    titleSmall: TextStyle(color: AppColors.errorDarkRed),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondaryDark, // Dodamo crvenu za gumbe
      foregroundColor: AppColors.accentDark, // Tekst na gumbima
    ),
  ),
);
