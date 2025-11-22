import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../screens/profile/update_information_screen.dart';

class MyInformationSection extends StatelessWidget {
  const MyInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, "My Information", "Edit"),
        const SizedBox(height: 15),
        _buildInfoWithSvg(context, 'assets/profile/person.svg', "Jacob Meikle"),
        _buildInfoWithSvg(context, 'assets/profile/person.svg', "Jacob Brothers"),
        _buildInfoWithSvg(context, 'assets/profile/person.svg', "Owner"),
        _buildInfoWithSvg(context, 'assets/profile/location.svg', "123 Oak Street Springfield, IL 62704"),
        _buildInfoWithSvg(context, 'assets/profile/phone.svg', "+1 012 345 6987"),
        _buildInfoWithSvg(context, 'assets/profile/mail.svg', "swe.monir@outlook.com"),
        _buildInfoWithSvg(context, 'assets/profile/mail.svg', "www.jacobbrothers.com"),
        _buildInfoWithSvg(context, 'assets/profile/mail.svg', "Service Area zip: 62704, 62705"),
        _buildInfoWithTimeAndSvg(context, 'assets/profile/calender.svg', "Mon - Fir", "9:00 AM - 6:00 PM"),
        _buildInfoWithSvg(context, 'assets/profile/calender.svg', "Joined: Aug 5, 2023"),
      ],
    );
  }

  Widget _buildInfoWithSvg(BuildContext context, String svgPath, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            svgPath,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              Colors.grey[600]!,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoWithTimeAndSvg(BuildContext context, String svgPath, String leftText, String rightText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            svgPath,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              Colors.grey[600]!,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leftText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                Text(
                  rightText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateInformationScreen(),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            backgroundColor: Colors.white,
          ),
          child: Text(
            action,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
