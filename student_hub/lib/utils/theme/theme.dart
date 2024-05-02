import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/utils/theme/custom_theme/app_bar_theme.dart';
import 'package:student_hub/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:student_hub/utils/theme/custom_theme/elevated_custom_theme.dart';
import 'package:student_hub/utils/theme/custom_theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: kBlue600,
    scaffoldBackgroundColor: kWhiteColor,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedCustomTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: kGrey0,
    scaffoldBackgroundColor: kGrey2,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedCustomTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
  );
}