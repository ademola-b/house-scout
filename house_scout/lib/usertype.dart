import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers.dart/usertype_controller.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultText.dart';

class UserType extends StatelessWidget {
  UserType({super.key});

  final controller = Get.put(UserTypeController());

  var container_color = Colors.white;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DefaultText(
                  text: "Are you",
                  color: Constants.primaryColor,
                  size: 30.0,
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeScouterColor(),
                        child: Obx(() => Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: controller.scouterColor.value,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  border: Border.all(
                                      color: Constants.primaryColor)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/home_addr.svg",
                                  ),
                                  const DefaultText(
                                    text: "Looking for a house",
                                    color: Constants.primaryColor,
                                    size: 20.0,
                                    align: TextAlign.center,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.changeLandlordColor();
                        },
                        child: Obx(() => Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: controller.landlordColor.value,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  border: Border.all(
                                      color: Constants.primaryColor)),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/landlord.svg",
                                  ),
                                  const DefaultText(
                                    text: "House Owner",
                                    color: Constants.primaryColor,
                                    size: 20.0,
                                    align: TextAlign.center,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.offNamed('/register');
                        },
                        child: const DefaultText(
                          text: 'Back',
                          color: Constants.primaryColor,
                          size: 20.0,
                        )),
                    Obx(() => DefaultButton(
                          onPressed: () {
                            Get.offNamed('/login');
                          },
                          text: "Submit",
                          textSize: 18.0,
                          color: controller.nextBtnColor.value,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
