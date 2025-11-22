
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naibrly/utils/app_icon.dart';
import '../../../../../controller/ProfileController/profilecontroller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../base/AppText/appText.dart';
import '../../../../base/Ios_effect/iosTapEffect.dart';
import '../../../../base/appTextfield/appTextfield.dart';
import '../../../../base/primaryButton/primary_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController _controller = Get.put(EditProfileController());
  final TextEditingController name=TextEditingController();
  final TextEditingController designations=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController phoneNumber=TextEditingController();
  final TextEditingController locations=TextEditingController();
  final TextEditingController zibcode=TextEditingController();

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
          centerTitle: true,
          leading: IosTapEffect(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset("assets/icons/icon/arrow-left.svg",height: 20,width: 20,),
              ),
              onTap: (){
                Get.back();
              }),
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: AppText(
            "Edit Profile",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.Black,
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                /// Profile Image
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Obx(() {
                        return Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.LightGray,
                              width: 1,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 56,
                            backgroundImage: _controller.selectedImageEDT.value != null
                                ? FileImage(_controller.selectedImageEDT.value!)
                                : NetworkImage(
                              _controller.userProfileImageUrl.value.isNotEmpty
                                  ? _controller.userProfileImageUrl.value
                                  : 'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
                            ) as ImageProvider,
                          ),
                        );
                      }),

                      /// Edit Icon
                      Positioned(
                        bottom: -2,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _controller.pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.White,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.LightGray,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppIcons.edit,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Align(
                  alignment: Alignment.center,
                  child: AppText(
                    'Upload Profile Photo',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.Black,
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                /// Name
                AppText("Name",fontWeight: FontWeight.w600,fontSize: 16,color: AppColors.black,),
                SizedBox(height: 10),
                AppTextField1(
                  controller: name,
                  hint: "Jane Doe",
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                /// Designation
                AppText("Designation",fontWeight: FontWeight.w600,fontSize: 16,color: AppColors.black,),
                SizedBox(height: 10),
                AppTextField1(
                  controller: designations,
                  hint: "Home owner",
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                /// Phone
                AppText("Phone Number",fontWeight: FontWeight.w500,fontSize: 16,color: AppColors.black,),
                SizedBox(height: 10),
                IntlPhoneField(
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.LightGray, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.DarkGray, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                  initialCountryCode: 'US',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
                /// Location
                AppText("Address",fontWeight: FontWeight.w500,fontSize: 16,color: AppColors.black,),
                SizedBox(height: 10),
                AppTextField1(
                  controller: locations,
                  hint: "123 Oak Street Springfield, IL 62704",
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                AppText("Zib Code",fontWeight: FontWeight.w500,fontSize: 16,color: AppColors.black,),
                SizedBox(height: 10),
                AppTextField1(
                  keyboardType: TextInputType.number,
                  controller: zibcode,
                  hint: "62704",
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ///----- Save Button ------///
                PrimaryButton(
                  text: "Save Changes",
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.back();
                    Get.snackbar("Profile edit?", "succesfull ProfileController edited");
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.080),
              ],
            ),
          ),
        )
    );
  }
}
