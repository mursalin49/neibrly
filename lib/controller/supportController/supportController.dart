import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SupportController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSent = false.obs;

  TextEditingController subject = TextEditingController();
  TextEditingController emailCompose = TextEditingController();

  void sendEmail() {
    if (isLoading.value) return;

    isLoading.value = true;
    isSent.value = false;


    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      isSent.value = true;


      Future.delayed(Duration(seconds: 2), () {
        isSent.value = false;
        subject.clear();
        emailCompose.clear();
      });
    });
  }

  @override
  void onClose() {
    subject.dispose();
    emailCompose.dispose();
    super.onClose();
  }
}