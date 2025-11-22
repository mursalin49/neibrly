import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naibrly/views/screen/Users/Profile/ProfileEdit/edit_profile.dart';
import 'package:naibrly/views/screen/Users/Profile/PrivacyPolicy/privacy_policy_screen.dart';
import 'package:naibrly/views/screen/Users/Profile/TermsCondition/terms_condition_screen.dart';
import 'package:naibrly/views/screen/Users/Profile/PaymentHistory/payment_history_screen.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icon.dart';
import '../../../base/AppText/appText.dart';
import '../../../base/CustomImage/customNetworkImage.dart';
import '../../../base/Ios_effect/iosTapEffect.dart';
import 'package:get/get.dart';
import 'Faq_screen/faq_screen.dart';
import 'base/iconTextRow.dart';
import 'base/settingItem.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController applycupon = TextEditingController();
  bool _notificationsExpanded = false;
  final ValueNotifier<bool> _textMsgController = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _emailController = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _onScreenController = ValueNotifier<bool>(true);
  final List<String> settingItem = [
    "Help & Support",
    "Privacy Policy",
    "Terms & Condition",
    "Payment History",
  ];

  @override
  void dispose() {
    applycupon.dispose();
    _textMsgController.dispose();
    _emailController.dispose();
    _onScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.White,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: AppColors.White,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: AppText("Your Profile",fontSize: 18,fontWeight: FontWeight.w700,color: AppColors.Black,),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.White,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.LightGray,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.edit,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (builder)=>EditProfileScreen()));

                  },
                ),
              ),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height *0.01),
                Align(
                  alignment: Alignment.center,
                  child: CustomNetworkImage(
                    imageUrl:'https://4kwallpapers.com/images/wallpapers/nissan-z-gt4-sema-race-cars-2023-5k-3840x2160-9042.jpeg',
                    height: 130,
                    width: 130,
                    boxShape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: AppColors.LightGray,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height *0.01),
                AppText(
                    "Jon Deo",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.Black
                ),
                SizedBox(height: 4),

                AppText(
                    "Home owner",
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.Black
                ),
                SizedBox(height: MediaQuery.of(context).size.height *0.05),
                Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                      'My Information',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textcolor
                  ),
                ),
                aboutSections(),
                SizedBox(height: MediaQuery.of(context).size.height *0.04),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      'Notifications',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.Black,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _notificationsExpanded = !_notificationsExpanded;
                        });
                      },
                      icon: Icon(
                        _notificationsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: AppColors.Black,
                      ),
                    ),
                  ],
                ),
                if (_notificationsExpanded) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        'Text message',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Black,
                      ),
                      AdvancedSwitch(
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.LightGray,
                        width: 44,
                        height: 22,
                        controller: _textMsgController,
                        borderRadius: BorderRadius.circular(77),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        'Email',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Black,
                      ),
                      AdvancedSwitch(
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.LightGray,
                        width: 44,
                        height: 22,
                        controller: _emailController,
                        borderRadius: BorderRadius.circular(77),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        'On-screen',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Black,
                      ),
                      AdvancedSwitch(
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.LightGray,
                        width: 44,
                        height: 22,
                        controller: _onScreenController,
                        borderRadius: BorderRadius.circular(77),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                const Divider(color: Color(0xFFEEEEEE)),

                SizedBox(height: 5),
                ListView.builder(
                  itemCount: settingItem.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final items = settingItem[index];
                    return SettingItem(
                      title: items,
                      iconPath: AppIcons.arrow_right,
                      onTap: () {
                        switch(index){
                          case 0:
                            Navigator.push(context,MaterialPageRoute(builder: (builder)=>FaqScreen()));
                            break;
                          case 1:
                            Navigator.push(context,MaterialPageRoute(builder: (builder)=>PrivacyPolicyScreen()));
                            break;
                          case 2:
                            Navigator.push(context,MaterialPageRoute(builder: (builder)=>TermsConditionScreen()));
                            break;
                          case 3:
                            Navigator.push(context,MaterialPageRoute(builder: (builder)=>PaymentHistoryScreen()));
                            break;
                        }
                      },
                    );
                  },
                ),

                SizedBox(height: 5),
                IosTapEffect(
                  onTap: (){
                    showCustomDialog(context);

                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: AppText(
                        'Logout',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height *0.02),
              ],
            ),
          ),
        ));
  }

  Padding aboutSections() {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          IconTextRow(
            iconPath: AppIcons.men,
            text: 'Jacob Meikle',
          ),

          SizedBox(height: 10),

          IconTextRow(
            iconPath: AppIcons.men,
            text: 'Home owner',
          ),

          SizedBox(height: 10),
          IconTextRow(
            iconPath: "assets/icons/locations.svg",
            text: '123 Oak Street Springfield, IL 62704',
          ),

          SizedBox(height: 10),
          IconTextRow(
            iconPath: AppIcons.call,
            text: '+1 012 345 6987',
          ),

          SizedBox(height: 10),
          IconTextRow(
            iconPath: AppIcons.mail,
            text: 'email@outlook.com',
          ),

          SizedBox(height: 10),
          IconTextRow(
            iconPath: AppIcons.mail,
            text: 'Zip: 62704',
          ),

          SizedBox(height: 10),
          IconTextRow(
            iconPath: AppIcons.calender,
            text: 'Joined: Aug 5, 2023 ',
          ),
        ],
      ),
    );
  }
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // tap outside to close
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // wrap content
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/maki_cross.svg")),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child:AppText("Log Out",color: AppColors.Black,fontSize: 20,fontWeight: FontWeight.bold,)),
                SizedBox(height: 8),
                Text(
                  "Are you sure you want to log out your account?",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: AppColors.DarkGray,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.LightGray,
                            borderRadius: BorderRadius.circular(12),
                          ), // control height via padding
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                "Cancel",
                                style: TextStyle(
                                  color: AppColors.Black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width *0.05,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop(); // Close dialog
                          //Get.to(SignInScreen());
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                "Log Out",
                                style: TextStyle(
                                  color: AppColors.White,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),



              ],
            ),
          ),
        );
      },
    );
  }

}
