import 'dart:async' show Timer;

import 'package:get/get.dart';

class VerifyController extends GetxController{
  var start = 60.obs; // countdown
  Timer? timer;
  void StartTimer(){
    start.value = 60;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1),(t){
      if(start.value<= 0){
        t.cancel();
      }else{
        start.value--;
      }
    });

  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StartTimer();
  }

}