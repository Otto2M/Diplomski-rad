import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static double getFontSize(double screenWidth,
      {double smallSize = 16, double mediumSize = 20, double largeSize = 24}) {
    if (screenWidth < 380) {
      return smallSize;
    } else if (screenWidth < 480) {
      //ili 420 ?
      return mediumSize; // Srednji uređaji (380px - 480px)
    } else {
      return largeSize;
    }
  }

  // Home screen - buttons
  static TextStyle homeScreenYellowButtons(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 18, mediumSize: 20, largeSize: 24);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

// --- GENERAL AND CATEGORIES SCREENS

  // Naslovni tekstovi za kategroije v2 - razlika u bold-u
  static placeHeadline2(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 18, largeSize: 24);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 18, mediumSize: 20, largeSize: 24);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 18);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 12, largeSize: 14);

    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
  }

// --- FAVORITES

  // Favorites screen - headline
  static TextStyle favoriteScreenSubcategoryHedaline(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 18, mediumSize: 20, largeSize: 24);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

// --- PERFECT DAY SCREEN

  //List View naslov - savrsen dan
  static TextStyle pdListViewTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 3,
    );
  }

  //List view opis - savrsen dan
  static TextStyle pdListViewDescriptions(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 13, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
  }

  //Opći opis - savrsen dan
  static TextStyle pdGeneralDescription(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

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
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 16, mediumSize: 20, largeSize: 24);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );
  }

  //Stil za tekst unutar drawer menu-a
  static TextStyle drawerMenuStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  //Stil za tekst unutar drawer menu-a
  static TextStyle drawerHeaderProfileTxt(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

// --- UPCOMING EVENTS

  //Upcoming events - card date style
  static TextStyle ueDateStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 16, mediumSize: 20, largeSize: 24);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  //Upcoming events - card text style
  static TextStyle ueTitleStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 12, largeSize: 14);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 16, mediumSize: 20, largeSize: 24);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 12, largeSize: 14);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 16, largeSize: 20);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 12, largeSize: 14);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  // Naslov mjesta podkategorije
  static subcategoryPlaceTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 16, mediumSize: 20, largeSize: 24);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 12, largeSize: 14);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 24, mediumSize: 28, largeSize: 32);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 12, largeSize: 14);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 8, mediumSize: 10, largeSize: 12);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Selected theme
  static profileSelectedTheme(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //Selected theme headline
  static profileSelectedThemeHeadline(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 18);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 16, mediumSize: 18, largeSize: 20);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //Profile alert box image picker
  static profileAlertBoxButtons(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 24, mediumSize: 26, largeSize: 28);

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
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //Review status star
  static reviewStatusStar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 24, mediumSize: 26, largeSize: 28);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

//LOGIN/REGISTRATION SCREEN

  //Headline
  static authHeadline(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 30, mediumSize: 40, largeSize: 60);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  //Label text style
  static authLabelTextStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  //Input text style
  static authInputTextStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 14, mediumSize: 16, largeSize: 18);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  //Button text style
  static authButtonTextStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 20, mediumSize: 22, largeSize: 24);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Text button text style
  static authTextBtnStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 10, mediumSize: 12, largeSize: 14);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.primary,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 2,
    );
  }

  //Welcome screen - Button text style
  static welcomeBtnTextStyle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 26, mediumSize: 28, largeSize: 30);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  //Splash screen - Text style
  static splashLogoText(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 46, mediumSize: 48, largeSize: 50);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

//ONBOARDING SCREEN

  //Title text style
  static onBordScrTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 22, mediumSize: 24, largeSize: 26);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //Description text style
  static onBordScrDesc(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  //Onboardin text button style - bottom row nav.
  static onBordScrInputBtnRowNav(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.primary,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

//CHATBOT

  //Chatbot - title
  static chatHeadline(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 18, mediumSize: 20, largeSize: 22);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      height: 2,
    );
  }

  //Chatbot - messages
  static chatMessages(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleLarge!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  //Chatbot - request messages style
  static chatResponseMessages(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleMedium!.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  //Chatbot - text input messages field
  static chatInputMessages(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 12, mediumSize: 14, largeSize: 16);

    return GoogleFonts.poppins(
      color: Theme.of(context).colorScheme.surface,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  static TextStyle errorText(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize =
        getFontSize(screenWidth, smallSize: 8, mediumSize: 12, largeSize: 14);

    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleSmall?.color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }
}
