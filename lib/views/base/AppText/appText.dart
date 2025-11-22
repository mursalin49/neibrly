
import 'package:flutter/material.dart';


class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextStyle? style; // If you want to override everything

  const AppText(
      this.text, {
        super.key,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.fontStyle,
        this.textAlign,
        this.overflow,
        this.maxLines,
        this.decoration,
        this.style,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: style ??
          TextStyle(
            letterSpacing: 0,
            height: 0,
            fontFamily: "Inter",
            fontSize: fontSize ?? 20,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontStyle: fontStyle ?? FontStyle.normal,
            decoration: decoration ?? TextDecoration.none,
            color: color ?? Colors.white38,
          ),
    );
  }
}
