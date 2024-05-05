import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';

class TElevatedCustomTheme {
  TElevatedCustomTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: kWhiteColor,
      backgroundColor: kBlue600,
      disabledBackgroundColor: kGrey1,
      disabledForegroundColor: kGrey1,
      side: const BorderSide(color: kBlue600),
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: kWhiteColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: kBlackColor,
      backgroundColor: kBlue600,
      disabledBackgroundColor: kGrey1,
      disabledForegroundColor: kGrey1,
      side: const BorderSide(color: kBlue600),
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: kBlackColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  // static ElevatedButtonThemeData lightElevatedButtonTheme =
  //     ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     backgroundColor: MaterialStateProperty.all(Colors.blue),
  //     shape: MaterialStateProperty.all(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //     ),
  //   ),
  // );

  // static ElevatedButtonThemeData darkElevatedButtonTheme =
  //     ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     backgroundColor: MaterialStateProperty.all(Colors.blue),
  //     shape: MaterialStateProperty.all(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //     ),
  //   ),
  // );
}
