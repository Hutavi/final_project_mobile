import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/constants/font.dart';

class BuildTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final Color fillColor;
  final Color hintColor;
  final int? maxLength;
  final Function onChange;
  final Function? validator;
  final String? validatorString;
  final String? labelText;

  const BuildTextField({
    super.key,
    this.hint,
    this.controller,
    required this.inputType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.fillColor = Colors.white,
    this.hintColor = const Color(0xff8D9091),
    this.maxLength,
    required this.onChange,
    this.validatorString,
    this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onChange(value);
      },
      validator: validator != null ? (value) => validator!(value) : null,
      keyboardType: inputType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: inputType == TextInputType.multiline ? 3 : 1,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
        counterText: '',
        fillColor: fillColor,
        filled: true,
        contentPadding: inputType == TextInputType.multiline
            ? const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10)
            : const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
        hintText: hint,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
            fontSize: textMedium,
            color: hintColor,
            fontWeight: FontWeight.w400),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(
          fontSize: textSmall,
          color: kRed,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 1, color: kBlue800),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: fillColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: kGrey1),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 0, color: kGrey1)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: kRed)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: kGrey1)),
        focusColor: kWhiteColor,
        hoverColor: kWhiteColor,
      ),
      cursorColor: kGrey1,
      style: const TextStyle(
        fontSize: textMedium,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
