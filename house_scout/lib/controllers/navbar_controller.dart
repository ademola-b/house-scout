import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  RxInt currentPage = 0.obs;

  late Rx<PageController> pageController;

  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController =
        PageController(initialPage: currentPage.value).obs ;
    print("pageController");
  }
}
