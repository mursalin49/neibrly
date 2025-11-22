import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SignUpController extends GetxController{
  RxBool showhide = false.obs;
  var privacy = false.obs;

  void passwordToggle(){
    showhide.value = ! showhide.value;
  }
}