import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    backgroundColor: kBlue600,
    foregroundColor: kBlue600,
    centerTitle: false,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: kWhiteColor),
    actionsIconTheme: IconThemeData(color: kWhiteColor),
    titleTextStyle: TextStyle(
      color: kWhiteColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    backgroundColor: kBlackAppBarTheme,
    foregroundColor: kBlackAppBarTheme,
    centerTitle: false,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: kWhiteColor),
    actionsIconTheme: IconThemeData(color: kWhiteColor),
    titleTextStyle: TextStyle(
      color: kWhiteColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );
}
