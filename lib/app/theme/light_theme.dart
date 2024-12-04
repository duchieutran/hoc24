import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: GoogleFonts.nunito().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.light,
    centerTitle: true,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColors.dark),
    titleTextStyle: text20.bold.textDarkColor,
  ),
  colorScheme: const ColorScheme.light(
    surface: AppColors.light,
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightGrey,
    tertiary: AppColors.nature30,
  ),
  scaffoldBackgroundColor: AppColors.light,
  textTheme: TextTheme(
    titleSmall: text14.bold.textDarkColor,
    titleMedium: text16.bold.textDarkColor,
    titleLarge: text18.bold.textDarkColor,
    labelSmall: text14.textLightColor,
    labelMedium: text16.textLightColor,
    labelLarge: text18.textLightColor,
    bodySmall: text14.textDarkColor,
    bodyMedium: text16.textDarkColor,
    bodyLarge: text18.textDarkColor,
  ),
  cardTheme: const CardTheme(
    color: AppColors.light,
    margin: EdgeInsets.zero, // Remove default margin
  ),
);
