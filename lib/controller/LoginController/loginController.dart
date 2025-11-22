import 'package:get/get.dart';

class LoginController extends GetxController{
  RxBool passShowHide = false.obs;
  void toggle(){
    passShowHide.value = ! passShowHide.value;
  }
}