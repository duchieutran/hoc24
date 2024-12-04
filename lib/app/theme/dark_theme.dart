import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.nunito().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    centerTitle: true,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColors.darkPrimary),
    titleTextStyle: text20.bold.textWhiteColor,
  ),
  colorScheme: const ColorScheme.dark(
    surface: AppColors.darkBackground,
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    tertiary: AppColors.darkSecondary,
  ),
  dialogBackgroundColor: AppColors.darkSecondary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: TextTheme(
    titleSmall: text14.bold.textWhiteColor,
    titleMedium: text16.bold.textWhiteColor,
    titleLarge: text18.bold.textWhiteColor,
    labelSmall: text14.textDarkColor,
    labelMedium: text16.textDarkColor,
    labelLarge: text18.textDarkColor,
    bodySmall: text14.textWhiteColor,
    bodyMedium: text16.textWhiteColor,
    bodyLarge: text18.textWhiteColor,
  ),
  cardTheme: const CardTheme(
    color: AppColors.darkSecondary,
    margin: EdgeInsets.zero, // Remove default margin
  ),
);
