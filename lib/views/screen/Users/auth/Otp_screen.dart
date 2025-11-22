import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:naibrly/controller/verifyController/verifyController.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/screen/Users/auth/set_new_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart' hide PinTheme;
import 'package:pinput/pinput.dart';

import '../../../base/AppText/appText.dart';
import '../../../base/Ios_effect/iosTapEffect.dart';
import '../../../base/primaryButton/primary_button.dart';
class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  VerifyController controller = Get.put(VerifyController());
  @override
  void initState() {
    super.initState();
    controller.StartTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AppText(
                "Authentication Code",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(text: "Enter 5-digit code we just texted to your Email",style: TextStyle(fontWeight: FontWeight.w400,color: AppColors.black)),
                    TextSpan(
                      text: " jhon@gmail.com",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                    ),

                  ],
                ),
              ),
            const SizedBox(height: 40),
            PincodeWidget(context),
            const SizedBox(height: 16),
            timerAndDonTget(),
            const SizedBox(height: 40),
            PrimaryButton(text: "Confirm", onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (builder)=> SetNewPassword()));

            }),

          ],
        ),
      ),
    );
  }

  final TextEditingController pincode = TextEditingController();
  Widget PincodeWidget(BuildContext context){
    return Pinput(
      controller: pincode,
      length: 4,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: AppColors.primary, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: AppColors.primary.withOpacity(0.05),
          border: Border.all(color: AppColors.primary),
        ),
      ),
      showCursor: true,
      onCompleted: (pin) {
        print("✅ Entered PIN: $pin");
      },
    );

  }

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(14), // ✅ Rounded corners
    ),
  );
  Widget timerAndDonTget(){
  return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          fontSize: 15,
          "Didn’t get the code?",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
          color:AppColors.Black,
        ),
        SizedBox(width: 4,),
        Obx(()=>AppText(
          fontSize: 15,
          "${controller.start.value} sec",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
          color: AppColors.primary,
        ),),
        Spacer(),
        IntrinsicWidth(
          child: Column(
            children: [
              IosTapEffect(
                onTap:()async{
                 // await controller.resendOtp(widget.email);
                },
                child: AppText(
                  "Resend",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:AppColors.primary,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 1.2,
                color: AppColors.primary,
              )
            ],
          ),
        ),
      ],
    );
  }
}
