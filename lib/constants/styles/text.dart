import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Home screen - buttons
  static TextStyle homeScreenYellowButtons(BuildContext context) {
    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

// --- GENERAL AND CATEGORIES SCREENS

  // Naslovni tekstovi za kategorije v1
  static TextStyle placeHeadline(BuildContext context) {
    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: 24,
      fontWeight: FontWeight.w800,
      height: 2,
    );
  }

  // Naslovni tekstovi za kategroije v2 - razlika u bold-u
  static placeHeadline2(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 18 : 24;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 2,
    );
  }

  // Opisni tekstovi
  static TextStyle description(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 11 : 15;

    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
  }

  //Naslovi glavnih kategorija
  static TextStyle categoryHeadline(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 18 : 24;
    // return TextStyle(
    //   fontFamily: GoogleFonts.poppins().fontFamily,
    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Tekst na buttonima
  static TextStyle placeButtonTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 13 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  // Opisni tekstovi
  static TextStyle categoryPlaceDescription(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 10 : 14;

    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
  }

// --- PERFECT DAY SCREEN

  //Opći opis - savrsen dan
  static TextStyle pdGeneralDescription(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 13 : 18;

    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
  }

  //Naslovi sekcija - savrsen dan
  static TextStyle pdSectionTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 15 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 3,
    );
  }

// --- DRAWER MENU

  //Stil za naslov drawer menu-a
  static TextStyle drawerMenuHeadline(BuildContext context) {
    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );
  }

  //Stil za tekst unutar drawer menu-a
  static TextStyle drawerMenuStyle(BuildContext context) {
    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

// --- UPCOMING EVENTS

  //Upcoming events - card date style
  static TextStyle ueDateStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 18 : 25;

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  //Upcoming events - card text style
  static TextStyle ueTitleStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 10 : 15;

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

// SUBCATEGORIES SCREEN

  // Naslov unutar kartice za naziv mjesta
  static subcategoryCardPlaceHeadline(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 15 : 24;

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  // Opis unutar kartice
  static subcategoryDesc(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 11 : 16;

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
  }

  // Naslov button-a podkategorije
  static subcategoryButtonTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 16 : 22;

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );
  }

  // Naslov za gumb unutar kartice
  static cardButtonTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 10 : 16;

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  // Naslov mjesta podkategorije
  static subcategoryPlaceTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 18 : 24;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 2,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.solid,
    );
  }

  // Detaljni podaci o mjestu
  static subcategoryPlaceDetailsStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 11 : 15;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  //Vremenska prognoza - modal bottom sheet - naslov
  static wfBottomModalTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 12 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  //Vremenska prognoza - modal bottom sheet - podaci
  static wfBottomModalData(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 10 : 16;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  //Vremenska prognoza - modal bottom sheet - podaci
  static wfBottomModalAdditionalData(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 10 : 16;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  //Vremenska prognoza - naslov grad
  static wfHomeTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 12 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  //Vremenska prognoza - temp.
  static wfHomeTemperature(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 24 : 32;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );
  }

  //Vremenska prognoza - temp. min. max.
  static wfHomeTemperatureMinMax(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 11 : 15;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  //Vremenska prognoza - po satima
  static wfHomeHourly(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 10 : 13;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

//MY PROFILE

  //general profile data
  static profileGeneralData(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 13 : 16;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Selected theme
  static profileSelectedTheme(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 13 : 15;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //Selected theme headline
  static profileSelectedThemeHeadline(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 14 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Profile buttons style
  static profileSaveCancleButtons(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 14 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  //Profile alert box image picker
  static profileAlertBoxTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 18 : 22;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Profile alert box image picker
  static profileAlertBoxDescription(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 14 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //Profile alert box image picker
  static profileAlertBoxButtons(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 16 : 20;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

//REVIEW PLACE SCREEN

  //Review message
  static reviewMessage(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 26 : 30;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Review status text
  static reviewStatusText(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 14 : 18;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //Review status star
  static reviewStatusStar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 24 : 28;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  // Tekst za linkove
  static final linkDescription = GoogleFonts.poppins(
    color: AppColors.lightBlue, // Plava za linkove
    fontSize: 16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
  );

  // Tekst za gumbe
  static final buttonText = GoogleFonts.poppins(
    color: AppColors.white, // Bijela boja za tekst gumba
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle errorText(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 420 ? 8 : 12;

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleSmall?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }
}
