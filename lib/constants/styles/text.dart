import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class TextStyles {
  // Naslovni tekstovi
  static final headline = GoogleFonts.poppins(
    color: AppColors.primaryLight, // Primarna plava boja
    fontSize: 20, // Prilagoditi prema dizajnu
    fontWeight: FontWeight.w700,
  );

  // Opisni tekstovi
  static final description = GoogleFonts.poppins(
    color: AppColors.accentLight, // Siva nijansa za opise
    fontSize: 16, // Prilagoditi prema dizajnu
    fontWeight: FontWeight.w400,
    height: 1.5, // Linijska visina za bolje čitanje
  );

  // Tekst za linkove
  static final linkDescription = GoogleFonts.poppins(
    color: AppColors.primaryLight, // Plava za linkove
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

  // Tekst za greške
  static final errorText = GoogleFonts.poppins(
    color: AppColors.errorLight, // Crvena boja za greške
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}
