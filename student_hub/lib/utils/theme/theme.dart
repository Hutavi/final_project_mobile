import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/utils/theme/custom_theme/app_bar_theme.dart';
import 'package:student_hub/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:student_hub/utils/theme/custom_theme/elevated_custom_theme.dart';
import 'package:student_hub/utils/theme/custom_theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: kBlue600,
      secondary: Color.fromRGBO(247, 242, 249, 1),
      error: kRed,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: kBlue600,
    scaffoldBackgroundColor: kWhiteColor,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedCustomTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    // bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kWhiteColor,
      selectedItemColor: kBlue600,
      unselectedItemColor: kGrey1,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: kBlue600,
      secondary: Color.fromRGBO(100, 100, 101, 1),
      error: kRed,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: kGrey0,
    scaffoldBackgroundColor: kGrey0,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedCustomTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kGrey0,
      selectedItemColor: kBlue600,
      unselectedItemColor: kGrey1,
    ),
  );
}
