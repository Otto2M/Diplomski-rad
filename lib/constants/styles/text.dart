import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
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
    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 2,
    );
  }

  // Opisni tekstovi
  static TextStyle description(BuildContext context) {
    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: 15,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );
  }

  //Naslovi glavnih kategorija
  static TextStyle categoryHeadline(BuildContext context) {
    // return TextStyle(
    //   fontFamily: GoogleFonts.poppins().fontFamily,
    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  //Tekst na buttonima
  static TextStyle placeButtonTitle(BuildContext context) {
    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleMedium?.color,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  // Opisni tekstovi
  static TextStyle categoryPlaceDescription(BuildContext context) {
    return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: 14,
      fontWeight: FontWeight.w300,
      height: 1.5,
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
    return GoogleFonts.poppins(
      color: Theme.of(context).textTheme.titleSmall?.color,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }
}
