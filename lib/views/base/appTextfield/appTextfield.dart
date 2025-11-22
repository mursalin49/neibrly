import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final Widget? suffix;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onSubmitted;

  const AppTextField({
    super.key,
    this.autocorrect = false,
    this.enableSuggestions = false,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      autocorrect: autocorrect ?? false,
      enableSuggestions: enableSuggestions ?? false,
      keyboardType: keyboardType,
      cursorColor: AppColors.secondary,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: hint,
        // Grey color when unfocused or empty
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.black50,  // Grey when not focused
          fontSize: 14,
        ),
        // Green color when focused (floating above)
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.primary,  // Green when focused
          fontSize: 14,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.White,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.black50.withOpacity(0.60),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}


class AppTextField1 extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final Widget? suffix;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onSubmitted;

  const AppTextField1({
    super.key,
    this.autocorrect = false,
    this.enableSuggestions = false,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      autocorrect: autocorrect ?? false,
      enableSuggestions: enableSuggestions ?? false,
      keyboardType: keyboardType,
      cursorColor: AppColors.secondary,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textcolor.withOpacity(0.70),
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textcolor.withOpacity(0.80),
          fontSize: 15,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.White,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              width: 1,
              color: AppColors.blackWhite
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(width: 1.5, color: AppColors.secondary.withOpacity(0.50)),
        ),
      ),
    );
  }
}