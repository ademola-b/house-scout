import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool favIcon = false.obs;
  var icon = const Icon(
    Icons.favorite_border,
    color: Colors.red,
    size: 30,
  ).obs;

  changeFavIcon() {
    favIcon.value = !favIcon.value;
    favIcon.value
        ? icon.value = const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 30,
          )
        : icon.value = const Icon(
            Icons.favorite_border,
            color: Colors.red,
            size: 30,
          );
  }
}
