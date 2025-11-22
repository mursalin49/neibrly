import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:naibrly/controller/setNewPassword/setnewPassController.dart';
import 'package:naibrly/views/base/bottomNav/bottomNavWrapper.dart';

import '../../../../utils/app_colors.dart';
import '../../../base/AppText/appText.dart';
import '../../../base/appTextfield/appTextfield.dart';
import '../../../base/primaryButton/primary_button.dart';
class SetNewPassword extends StatelessWidget {
  SetNewPassword({super.key});

  final SetNewPasswordController controller = Get.put(SetNewPasswordController());
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    "Enter New Password",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                AppText("Set Complex passwords to protect",fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.secondary,),
                const SizedBox(height: 20),
                ReusablePasswordField(
                  title: "Password",
                  controller: passwordController,
                  showHide: controller.showhide,
                  toggleVisibility: controller.passwordToggle,
                  hint: "Enter new password",
                ),
                const SizedBox(height: 20),
                ReusablePasswordField(
                  title: "Re Type Password",
                  controller: confirmController,
                  showHide: controller.showhideConfirm,
                  toggleVisibility: controller.confirmPasswordToggle,
                  hint: "Confirm password",
                ),
                const SizedBox(height: 32),
                PrimaryButton(text: "Set New Password", onTap: (){
                  // Navigate to main user app after successful password setup
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => BottomMenuWrappers()),
                    (Route<dynamic> route) => false,
                  );
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
            )
        )
        );
  }
}

class ReusablePasswordField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final RxBool showHide;
  final VoidCallback toggleVisibility;

  const ReusablePasswordField({
    super.key,
    required this.title,
    required this.controller,
    required this.showHide,
    required this.toggleVisibility,
    this.hint = "Enter password",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.textprimaruy,
        ),
        const SizedBox(height: 8),
        Obx(
              () => AppTextField(
            obscure: showHide.value,
            controller: controller,
            hint: hint,
            keyboardType: TextInputType.visiblePassword,
            suffix: IconButton(
              icon: Icon(
                showHide.value ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                color: Colors.black.withOpacity(0.5),
              ),
              onPressed: toggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}

