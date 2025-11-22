import 'package:flutter/material.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../base/AppText/appText.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final Color? lineColor;
  final double lineThickness;
  final double spacing;
  final TextStyle? textStyle;

  const OrDivider({
    super.key,
    this.text = "Or continue with",
    this.lineColor,
    this.lineThickness = 1,
    this.spacing = 10,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: lineThickness,
            color: lineColor ?? AppColors.textcolor,
          ),
        ),
        SizedBox(width: spacing),
        AppText(
          text,
          fontSize: textStyle?.fontSize ?? 14,
          fontWeight: textStyle?.fontWeight ?? FontWeight.w400,
          color: textStyle?.color ?? AppColors.secondary,
        ),
        SizedBox(width: spacing),
        Expanded(
          child: Container(
            height: lineThickness,
            color: lineColor ?? AppColors.textcolor,
          ),
        ),
      ],
    );
  }
}
