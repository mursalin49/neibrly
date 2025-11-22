import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/screen/Users/auth/Otp_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../base/appTextfield/appTextfield.dart';
import '../../../base/primaryButton/primary_button.dart';

class ResetScreen extends StatelessWidget {
  ResetScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController pincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // ✅ add this
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AppText(
                "Reset Your Password",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(

              "Enter your email address below and we’ll send you a link with instructions.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                letterSpacing: 0,
              ),
              textAlign: TextAlign.start, // ✅ center text too
            ),
            const SizedBox(height: 30),
            // 🖼️ Image 2
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(
                "assets/images/Group 513789 (2).png",
                width: MediaQuery.of(context).size.width * 0.7, // optional
              ),
            ),
            const SizedBox(height: 40),
            AppTextField(controller: email, hint: "Email Address"),
            const SizedBox(height: 32),
            PrimaryButton(text: "Send Verification Code", onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>OtpScreen()));

            }),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText("Need Help ",fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.black,),
                Container(
                  height: 20,
                  width: 2,
                  color: AppColors.black,
                ),
                AppText(" FAQ ",fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.black,),
                Container(
                  height: 20,
                  width: 2,
                  color: AppColors.black,
                ),
                AppText(" Terms Of use ",fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.black,),
              ],
            ),

          ],
        ),
      ),

    );
  }
}
