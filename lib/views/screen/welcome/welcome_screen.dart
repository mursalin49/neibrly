import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/screen/auth/login_screen.dart';
import 'package:naibrly/views/screen/Users/auth/sign_up.dart';
import 'package:naibrly/provider/screens/information_screen.dart';
import '../../base/AppText/appText.dart';
import '../../base/Ios_effect/iosTapEffect.dart';
import '../../base/bottomNav/bottomNavWrapper.dart';
import '../../base/primaryButton/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectedLanguage = "EN"; // stores selected language
  final List<String> languages = ["EN", "BN", "ES", "FR"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: buildLanguageSelector(languages, selectedLanguage, setState),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/Image (1).png",
                  height: 216,
                  width: 272,
                ),
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Welcome to",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: " Naibrly?",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF0E7A60),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText(
                "A place to find all your home services and the chance to join your friends and neighbors to save money",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              onTap: () {
                showCustomDialog(context);
              },
              text: "Create account",
            ),
            const SizedBox(height: 10),
            IosTapEffect(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => LoginScreen()),
                );
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.primary, width: 1.0),
                ),
                child: Center(
                  child: AppText(
                    "Sign in",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Skip(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomMenuWrappers()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            //const SizedBox(height: 20),
            // ProviderButton(
            //   onTap: () {
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(builder: (context) => NairblyApp()),
            //       (Route<dynamic> route) => false,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    "Please select:",
                    color: AppColors.textcolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    textColor: AppColors.primary,
                    backgroundColor: AppColors.primary.withOpacity(0.10),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Customer Signup
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    text: "Customer",
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    textColor: AppColors.primary,
                    backgroundColor: AppColors.primary.withOpacity(0.10),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Service Provider Information Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YourInformationScreen(),
                        ),
                      );
                    },
                    text: "Service Provider",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //--===-- Language popup menu --==--
  PopupMenuButton buildLanguageSelector(
    List<String> languages,
    String? selectedValue,
    StateSetter setState,
  ) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 45),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        setState(() {
          selectedLanguage = value;
        });

        // Optionally: trigger language change logic here
        debugPrint("Selected Language: $value");
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          enabled: false,
          child: AppText(
            "Select Language",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff71717A),
          ),
        ),
        ...languages.map(
          (lang) => PopupMenuItem<String>(
            value: lang,
            child: Row(
              children: [
                if (selectedLanguage == lang)
                  const Icon(Icons.check, color: Colors.green, size: 16),
                if (selectedLanguage == lang) const SizedBox(width: 6),
                AppText(
                  lang,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
      child: Container(
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: Color(0xFF0E7A60).withOpacity(0.10),
          ),
        ),
        child: Row(
          children: [
            AppText(
              selectedLanguage ?? "EN",
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.black,
            ),
            const SizedBox(width: 6),
            SvgPicture.asset("assets/icons/arrow-down.svg"),
          ],
        ),
      ),
    );
  }
}

class Skip extends StatelessWidget {
  final VoidCallback onTap;

  const Skip({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IosTapEffect(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            "Skip",
            fontSize: 18,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          SvgPicture.asset("assets/icons/IC_chevron-right (1).svg"),
        ],
      ),
    );
  }
}

// class ProviderButton extends StatelessWidget {
//   final VoidCallback onTap;
//
//   const ProviderButton({super.key, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return IosTapEffect(
//       onTap: onTap,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AppText(
//             "Provider",
//             fontSize: 18,
//             color: AppColors.primary,
//             fontWeight: FontWeight.w600,
//           ),
//           SvgPicture.asset("assets/icons/IC_chevron-right (1).svg"),
//         ],
//       ),
//     );
//   }
// }
