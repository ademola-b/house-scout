import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/utils/defaultText.dart';

class BtnController extends GetxController {
  var passwordHidden = true.obs;
  var locationTileStatus = const Icon(Icons.arrow_forward_ios).obs;


  var isClicked = false.obs;

  Widget circ(String action) {
    if (isClicked.value) {
      print(isClicked);
      return const CircularProgressIndicator();
    } else {
      print(isClicked);
      return DefaultText(text: action, color: Colors.white, size: 18.0);
    }
  }
}
