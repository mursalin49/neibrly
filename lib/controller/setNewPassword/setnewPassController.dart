
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SetNewPasswordController extends GetxController{
 RxBool showhide = false.obs;
 RxBool showhideConfirm = false.obs;
 void passwordToggle(){
   showhide.value =! showhide.value;
 }
 void confirmPasswordToggle(){
   showhideConfirm.value =! showhideConfirm.value;
 }
}