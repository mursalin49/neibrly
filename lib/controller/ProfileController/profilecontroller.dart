import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileController extends GetxController {

  RxString userProfileImageUrl = ''.obs;

  Rx<File?> selectedImageEDT = Rx<File?>(null);
  RxString imagesPath = ''.obs;
  Future pickImage(ImageSource source)async{
    final XFile? pickedFile =  await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;
    final Extentions = pickedFile.path.split('.').last.toLowerCase();
    if(!['jpg', 'jpeg', 'png'].contains(Extentions)){
      Get.snackbar("Invalid Format", "Only JPG, JPEG, PNG files are allowed.");
      return;
    }

    selectedImageEDT.value = File(pickedFile.path);
    imagesPath.value = selectedImageEDT.value!.path;
    update();

  }
}