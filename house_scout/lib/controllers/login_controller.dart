import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/utils/defaultText.dart';

class LoginController extends GetxController {
  var passwordHidden = true.obs;

  var isClicked = false.obs;

  Widget circ(String action) {
    if (isClicked.value) {
      return const CircularProgressIndicator();
    } else {
      return DefaultText(text: action, color: Colors.white, size: 18.0);
    }
  }
}
