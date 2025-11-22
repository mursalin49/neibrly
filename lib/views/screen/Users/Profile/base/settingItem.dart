import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../base/AppText/appText.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? titleColor;
  final double? iconSize;

  const SettingItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.showDivider = true,
    this.titleColor,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // splashColor: AppColors.secondary.withOpacity(0.08),
      // highlightColor: AppColors.secondary.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: titleColor ?? AppColors.Black,
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  iconPath,
                  width: iconSize,
                  height: iconSize,
                  colorFilter: ColorFilter.mode(
                    AppColors.Black.withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            if (showDivider) ...[
              const SizedBox(height: 5),
              const Divider(
                color: Color(0xFFEEEEEE),
                height: 1,
                thickness: 1,
              ),
            ],
          ],
        ),
      ),
    );
  }
}