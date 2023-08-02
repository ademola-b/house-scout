import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/utils/constants.dart';

class UserTypeController extends GetxController {
  var nextBtnColor = Colors.white.obs;
  var landlordColor = Colors.white.obs;
  var scouterColor = Colors.white.obs;
  var toggleColor = false.obs;

  void changeColor() {
    toggleColor.value = !toggleColor.value;
    if (toggleColor.value) {
      scouterColor.value = Constants.containerColor;
      landlordColor.value = Colors.white;
    } else {
      landlordColor.value = Constants.containerColor;
      scouterColor.value = Colors.white;
    }
  }

  void changeLandlordColor() {
    nextBtnColor.value = Constants.primaryColor;
    landlordColor.value = Constants.containerColor;
    scouterColor.value = Colors.white;
  }

  void changeScouterColor() {
    nextBtnColor.value = Constants.primaryColor;
    scouterColor.value = Constants.containerColor;
    landlordColor.value = Colors.white;
  }
}
