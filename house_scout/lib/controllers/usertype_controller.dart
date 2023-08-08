import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';

class UserTypeController extends GetxController {
  var nextBtnColor = Colors.white.obs;
  var landlordColor = Colors.white.obs;
  var scouterColor = Colors.white.obs;
  RxBool toggleColor = false.obs;
  RxBool btnDisabled = true.obs;
  RxBool userType = false.obs;
  RxBool isClicked = false.obs;


  void changeLandlordColor() {
    nextBtnColor.value = Constants.primaryColor;
    btnDisabled.value = false;
    userType.value = true;
    landlordColor.value = Constants.containerColor;
    scouterColor.value = Colors.white;
  }

  void changeScouterColor() {
    nextBtnColor.value = Constants.primaryColor;
    btnDisabled.value = false;
    userType.value = false;
    scouterColor.value = Constants.containerColor;
    landlordColor.value = Colors.white;
  }

  Widget circ(String action) {
    if (isClicked.value) {
      return const CircularProgressIndicator();
    } else {
      return DefaultText(text: action, color: Colors.white, size: 18.0);
    }
  }
}
