import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/navbar_controller.dart';
import 'package:house_scout/house_owner/dashboard.dart';
import 'package:house_scout/house_owner/post_properties.dart';
import 'package:house_scout/more.dart';
import 'package:house_scout/scouter/dashboard.dart';
import 'package:house_scout/scouter/favs.dart';
import 'package:house_scout/utils/constants.dart';

import '../utils/defaultText.dart';

class ScouterNavBar extends StatelessWidget {
  ScouterNavBar({super.key});
  var controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentPage.value,
            children: const [ScouterDashboard(), Favs(), More()],
          )),
      bottomNavigationBar: Obx(() => CircleNavBar(
            onTap: (index) {
              controller.currentPage.value = index;
            },
            activeIndex: controller.currentPage.value,
            activeIcons: const [
              Icon(Icons.home, size: 40, color: Constants.containerColor),
              Icon(Icons.favorite, size: 40, color: Constants.containerColor),
              Icon(Icons.more_horiz, size: 40, color: Constants.containerColor),
            ],
            inactiveIcons: const [
              DefaultText(
                text: "Home",
                color: Constants.containerColor,
                weight: FontWeight.bold,
                size: 15,
              ),
              DefaultText(
                text: "Favourites",
                color: Constants.containerColor,
                size: 15,
              ),
              DefaultText(
                text: "More",
                color: Constants.containerColor,
                size: 15,
              ),
            ],
            height: 70,
            circleWidth: 70,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            cornerRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            color: Constants.primaryColor,
            shadowColor: Constants.containerColor,
            circleShadowColor: Colors.orange,
            elevation: 20,
          )),
    );
  }
}
