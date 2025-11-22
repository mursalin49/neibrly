import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:naibrly/controller/signupController/signupController.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/appTextfield/appTextfield.dart';
import 'package:naibrly/views/base/primaryButton/primary_button.dart';
import 'package:naibrly/views/screen/Users/auth/Otp_screen.dart';

import '../../../../utils/app_icon.dart';
class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController streetNumberName = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController aptsuite = TextEditingController();
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18, 0, 18, MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 45,),
            Align(
          alignment: Alignment.center,
          child: Image.asset("assets/images/Frame 2147226486.png",width: 155,height: 48,),),
            SizedBox(height: 25,),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFFEBFBFE),
                  child: Center(
                    child: SvgPicture.asset("assets/icons/user_color.svg",),
                  ),
                ),
                SizedBox(width: 8,),
                UploadImage(),
              ],
            ),
            SizedBox(height: 12,),
            Row(
              children: [
                Expanded(child: AppTextField(controller: firstname, hint: "First Name")),
                SizedBox(width: 10,),
                Expanded(child: AppTextField(controller: firstname, hint: "Last Name")),

              ],
            ),
            SizedBox(height: 10,),
            AppTextField(controller: firstname, hint: "Email Address"),
            SizedBox(height: 10,),
            Obx(
                  () => AppTextField(
                obscure: controller.showhide.value,
                // ✅ dynamic obscure
                keyboardType: TextInputType.twitter,
                controller: password,
                // ✅ use passwordController here
                hint: "Password",
                suffix: IconButton(
                  icon: Icon(
                    controller.showhide.value
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: Colors.black.withOpacity(0.50),
                  ),
                  onPressed: () {
                    controller.passwordToggle();
                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            Obx(
                  () => AppTextField(
                obscure: controller.showhide.value,
                // ✅ dynamic obscure
                keyboardType: TextInputType.twitter,
                controller: password,
                // ✅ use passwordController here
                hint: "Confirm Password",
                suffix: IconButton(
                  icon: Icon(
                    controller.showhide.value
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: Colors.black.withOpacity(0.50),
                  ),
                  onPressed: () {
                    controller.passwordToggle();
                  },
                ),
              ),
            ),
            //AppTextField(controller: firstname, hint: "")
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: AppTextField(controller: firstname, hint: "State")),
                SizedBox(width: 10,),
                Expanded(child: AppTextField(controller: firstname, hint: "Zib Code")),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: AppTextField(controller: firstname, hint: "City")),
                SizedBox(width: 10,),
                Expanded(child: AppTextField(controller: firstname, hint: "Apt / Suite")),

              ],
            ),
            SizedBox(height: 10,),
            Row(
            children: [
              Obx(
                    () => Transform.scale(
                  scale: 1.1, // adjust size as needed
                  child: Checkbox(
                    value: controller.privacy.value,
                    onChanged: (val) {
                      controller.privacy.value = val ?? false; // ✅ assignment, not comparison
                    },
                    activeColor: AppColors.primary,
                    checkColor: Colors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).textTheme.titleSmall?.color ?? Colors.grey,
                      width: 0.8,
                    ),
                  ),
                ),
              ),
              // 🧩 RichText beside the checkbox
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(text: "I agree to the ",style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.black)),
                      TextSpan(
                        text: "Terms of Service & Privacy Policy",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // 👇 Handle tap here (navigate or open URL)
                            Get.toNamed('/privacyPolicy');
                          },
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
            SizedBox(height: 20,),
            PrimaryButton(text: "Sign Up", onTap: (){
              // Navigate to OTP verification screen after signup
              Navigator.push(context, MaterialPageRoute(builder: (builder)=> OtpScreen()));

            }),
            SizedBox(height: 20,),
            orDivided(),
            SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffeeeeee),
                        offset: Offset(0, 3),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(100),

                  ),
                  child: SvgPicture.asset(AppIcons.google),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffeeeeee),
                        offset: Offset(0, 3),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(100),

                  ),
                  child: SvgPicture.asset(AppIcons.apple),
                ),
              ],
            )
          ]
          )
        ),
      ),
    );
  }
  
  Widget orDivided(){
    return Row(
      children: [
       Expanded(
         child: Container(
           height: 1,
           color: AppColors.secondary,
         ),
       ), 
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8.0),
         child: AppText("Or continue with",fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.black,),
       ),
       Expanded(
         child: Container(
           height: 1,
           color: AppColors.secondary,
         ),
       ), 
      ],
    );
  }
}
class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: AppColors.black50,
        ),
      ),
      child: Row(
        children: [
          AppText("upload Image",color: AppColors.black,fontSize: 18,fontWeight: FontWeight.w400,),
          SizedBox(width: 8,),
          SvgPicture.asset("assets/icons/elements (4).svg"),
        ],
      ),
    );
  }
}

