import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoc24/app/config/app_colors.dart';

final fontApp = TextStyle(fontFamily: GoogleFonts.nunito().fontFamily, fontWeight: FontWeight.w400);

TextStyle get text8 => fontApp.copyWith(fontSize: 8.0);

TextStyle get text10 => fontApp.copyWith(fontSize: 10.0);

TextStyle get text11 => fontApp.copyWith(fontSize: 11.0);

TextStyle get text12 => fontApp.copyWith(fontSize: 12.0);

TextStyle get text13 => fontApp.copyWith(fontSize: 13.0);

TextStyle get text14 => fontApp.copyWith(fontSize: 14.0);

TextStyle get text15 => fontApp.copyWith(fontSize: 15.0);

TextStyle get text16 => fontApp.copyWith(fontSize: 16.0);

TextStyle get text18 => fontApp.copyWith(fontSize: 18.0);

TextStyle get text20 => fontApp.copyWith(fontSize: 20.0);

TextStyle get text22 => fontApp.copyWith(fontSize: 22.0);

TextStyle get text24 => fontApp.copyWith(fontSize: 24.0);

TextStyle get text26 => fontApp.copyWith(fontSize: 26.0);

TextStyle get text28 => fontApp.copyWith(fontSize: 28.0);

TextStyle get text30 => fontApp.copyWith(fontSize: 30.0);

TextStyle get text32 => fontApp.copyWith(fontSize: 32.0);

TextStyle get text34 => fontApp.copyWith(fontSize: 34.0);

TextStyle get text36 => fontApp.copyWith(fontSize: 36.0);

extension TextStyleExt on TextStyle {
  //Decoration style
  TextStyle get none => copyWith(decoration: TextDecoration.none);

  TextStyle get underLine => copyWith(decoration: TextDecoration.underline);

  TextStyle get overLine => copyWith(decoration: TextDecoration.overline);

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get thickNess2 => copyWith(decorationThickness: 2);

  //Weight style
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  //Height style
  TextStyle get height14Per => copyWith(height: 1.4);

  TextStyle get height15Per => copyWith(height: 1.5);

  TextStyle get height16Per => copyWith(height: 1.6);

  TextStyle get height17Per => copyWith(height: 1.7);

  TextStyle get height18Per => copyWith(height: 1.8);

  TextStyle get height19Per => copyWith(height: 1.9);

  TextStyle get height20Per => copyWith(height: 2.0);

  TextStyle get height21Per => copyWith(height: 2.1);

  TextStyle get height22Per => copyWith(height: 2.2);

  TextStyle get height40Per => copyWith(height: 4);

  //Color style
  TextStyle get textDarkColor => copyWith(color: AppColors.dark);

  TextStyle get textLightColor => copyWith(color: AppColors.light);

  TextStyle get textWhiteColor => copyWith(color: AppColors.darkText);

  TextStyle get textPrimaryColor => copyWith(color: AppColors.lightPrimary);

  TextStyle get textGreyColor => copyWith(color: AppColors.lightGrey);

  TextStyle get textNature20Color => copyWith(color: AppColors.nature20);

  TextStyle get textNature30Color => copyWith(color: AppColors.nature30);

  TextStyle get textRedColor => copyWith(color: Colors.red);

  TextStyle get textBlueColor => copyWith(color: AppColors.lightBlue30);
}
