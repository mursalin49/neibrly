import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../base/AppText/appText.dart';
class IconTextRow extends StatelessWidget {
  final String iconPath;
  final String text;
  final double iconSize;
  final double spacing;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const IconTextRow({
    super.key,
    required this.iconPath,
    required this.text,
    this.iconSize = 24,
    this.spacing = 10,
    this.textColor = AppColors.Black,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: iconSize, height: iconSize),
        SizedBox(width: spacing),
        AppText(
          text,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ],
    );
  }
}