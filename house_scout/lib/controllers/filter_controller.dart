import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  RxInt selectedIndex = 1.obs;
  RxBool selected = false.obs;

  var iconColor = Colors.white.obs;
  RxList categList = [].obs;
  RxList propList = [].obs;
  RxList bedNumList = [].obs;
  RxList bathList = [].obs;
  RxList kitchenList = [].obs;
  RxList furnishedType = [].obs;
  RxList tenantType = [].obs;

  iconColorChange() {
    if (selected.value) {
      iconColor.value = Colors.white;
    }
  }

  clearAll() {
    categList.clear();
    propList.clear();
    bedNumList.clear();
    bathList.clear();
    kitchenList.clear();
    furnishedType.clear();
    tenantType.clear();
  }
}
