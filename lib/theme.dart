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

final appTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.primaryLight,
    primaryContainer: AppColors.accentLight,
    secondary: AppColors.secondaryLight,
    secondaryContainer: AppColors.primaryLight.withOpacity(0.2),
    surface: AppColors.backgroundLight,
    error: AppColors.errorLight,
    onPrimary: AppColors.white,
    onSecondary: AppColors.black,
    onSurface: AppColors.black,
    onError: AppColors.white,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryLight,
    foregroundColor: AppColors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.black),
    bodyMedium: TextStyle(color: AppColors.black),
    titleLarge: TextStyle(color: AppColors.primaryLight),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondaryLight, // Dodamo crvenu za gumbe
      foregroundColor: AppColors.accentLight, // Tekst na gumbima
    ),
  ),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.primaryDark,
    primaryContainer: AppColors.accentDark,
    secondary: AppColors.secondaryDark,
    secondaryContainer: AppColors.primaryDark.withOpacity(0.2),
    surface: AppColors.backgroundDark,
    error: AppColors.errorDark,
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
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondaryLight, // Dodamo crvenu za gumbe
      foregroundColor: AppColors.accentLight, // Tekst na gumbima
    ),
  ),
);
