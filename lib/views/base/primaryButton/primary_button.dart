import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../AppText/appText.dart';
import '../Ios_effect/iosTapEffect.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double borderRadius;
  final FontWeight fontWeight;
  final double fontSize;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.height = 48,
    this.borderRadius = 10,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IosTapEffect(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor ?? AppColors.primary,
        ),
        child: Center(
          child: AppText(
            text,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
