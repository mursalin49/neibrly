import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../controller/supportController/supportController.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../base/AppText/appText.dart';
import '../../../../base/Ios_effect/iosTapEffect.dart';
import '../base/settingItem.dart' show SettingItem;

class SupportsScreen extends StatelessWidget {
  SupportsScreen({super.key});

  SupportController controller = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        elevation: 0,
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/icon/arrow-left.svg",
            color: Colors.black,
            width: 24,
            height: 24,
          ),
        ),

        title: AppText(
          "Contact Support",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Obx(
            () => AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: controller.isSent.value
                  ? SizedBox(
                height: MediaQuery.of(context).size.height -
                    kToolbarHeight - // account for AppBar height
                    MediaQuery.of(context).padding.top,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // shrink to content
                    children: [
                      SvgPicture.asset("assets/images/Group 758530841.svg"),
                      SizedBox(height: 16),
                      AppText(
                        "Thank you!",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                      SizedBox(height: 8),
                      AppText(
                        "Thank you! We have received your request\nand will get back to you soon.",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.DarkGray,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          SettingItem(
                            showDivider: false,
                            title: "Select one Issue",
                            iconSize: 10,
                            titleColor: AppColors.secondary,
                            iconPath: "assets/icons/elements (3).svg",
                            onTap: () {
                              // Navigator.push(context,MaterialPageRoute(builder: (builder)=>FaqScreen()));
                            },
                          ),

                          Container(height: 1, color: AppColors.LightGray),

                         SizedBox(
                           height:MediaQuery.of(context).size.height * 0.7,
                           child: TextFormField(
                                controller: controller.emailCompose,
                                keyboardType: TextInputType.multiline,
                                maxLines: null, // ✅ allows infinite lines
                                minLines: 6, // starts with 6 lines
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  hintText: "Compose your email...",
                                  hintStyle: TextStyle(
                                    color: AppColors.black50,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none, // remove default underline
                                  isCollapsed: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.Black,
                                  height: 1.5, // spacing between lines
                                ),
                              ),
                         ),


                          Obx(
                            () => IosTapEffect(
                              onTap: () {
                                controller.sendEmail();
                                Future.delayed(Duration(seconds: 3), () {
                                  Get.back();
                                });
                              },
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                  child: controller.isLoading.value
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/Paperplane icon.svg",
                                            ),
                                            SizedBox(width: 8),
                                            AppText(
                                              "Send",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.White,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
