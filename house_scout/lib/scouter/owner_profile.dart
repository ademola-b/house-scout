import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_scout/models/house_owner_prop.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';

class OwnerPropController extends GetxController {
  RxInt propertiesLength = 0.obs;

  var data = Get.arguments;

  props() async {
    List<HouseOwnerProperty>? props =
        await RemoteServices.houseOwnerProperties(owner: data['profile'].pk);

    if (props!.isNotEmpty) {
      propertiesLength.value = props.length;
    }

    print(propertiesLength);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    props();
  }
}

class OwnerProfile extends StatelessWidget {
  OwnerProfile({super.key});

  var data = Get.arguments;
  var ownerProp = Get.put(OwnerPropController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  const DefaultText(
                    text: "Profile",
                    color: Colors.orange,
                    size: 25.0,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "assets/images/bld.jpeg",
                        width: size.width,
                        height: size.height / 4.5,
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                    bottom: -70,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(color: Colors.orange, width: 5.0),
                      ),
                      child: data['profile'].imageMem == null
                          ? ClipOval(
                              child: Image.asset(
                                "assets/images/default.jpg",
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.memory(
                                data['profile'].imageMem,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: -100,
                    child: DefaultText(
                      text:
                          "${data['profile'].firstName}  ${data['profile'].lastName}",
                      color: Colors.grey[900],
                      size: 20.0,
                    ),
                  ),
                  Positioned(
                    bottom: -130,
                    child: data['profile'].address == null
                        ? DefaultText(
                            text: "Address",
                            color: Colors.grey[900],
                            size: 20.0,
                          )
                        : DefaultText(
                            text: data['profile'].address,
                            color: Colors.grey[900],
                            size: 20.0,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 130.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        const DefaultText(
                          text: "Total Posts",
                          color: Colors.black87,
                          size: 15,
                        ),
                        Obx(() => DefaultText(
                              text: ownerProp.propertiesLength.toString(),
                              color: Colors.black87,
                              size: 18,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: const [
                        DefaultText(
                          text: "Total Deals",
                          color: Colors.black87,
                          size: 15,
                        ),
                        DefaultText(
                          text: "100",
                          color: Colors.black87,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: const [
                        DefaultText(
                          text: "don't know",
                          color: Colors.black87,
                          size: 15,
                        ),
                        DefaultText(
                          text: "null",
                          color: Colors.black87,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      data['profile'].phone != null
                          ? Get.defaultDialog(
                              title: "",
                              barrierDismissible: false,
                              content: Column(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/outgoing_call.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(height: 10.0),
                                  DefaultText(
                                      text: "call ${data['profile'].phone} ?",
                                      size: 18.0)
                                ],
                              ),
                              actions: [
                                  TextButton(
                                      onPressed: () => Get.close(1),
                                      child: const DefaultText(
                                        text: "No",
                                        size: 18.0,
                                        color: Colors.orange,
                                      )),
                                  TextButton(
                                      onPressed: () {},
                                      child: const DefaultText(
                                        text: "Yes",
                                        size: 18.0,
                                        color: Colors.green,
                                      )),
                                ])
                          : Get.defaultDialog(
                              title: "",
                              content: Column(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/outgoing_call.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(height: 10.0),
                                  const DefaultText(
                                      text: "Owner didn't provide phone number")
                                ],
                              ),
                              actions: [
                                  TextButton(
                                      onPressed: () => Get.close(1),
                                      child: const DefaultText(
                                        text: "Okay",
                                        size: 18.0,
                                        color: Colors.orange,
                                      )),
                                ]);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.call, color: Colors.orange),
                          SizedBox(width: 10.0),
                          DefaultText(
                            text: "Call",
                            color: Colors.black87,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/chat'),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.chat, color: Colors.orange),
                          SizedBox(width: 10.0),
                          DefaultText(
                            text: "Chat",
                            color: Colors.black87,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      data['profile'].email != null
                          ? Get.defaultDialog(
                              title: "",
                              barrierDismissible: false,
                              content: Column(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/send_email.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  DefaultText(
                                      text: "Email ${data['profile'].email} ?",
                                      size: 18.0)
                                ],
                              ),
                              actions: [
                                  TextButton(
                                      onPressed: () => Get.close(1),
                                      child: const DefaultText(
                                        text: "No",
                                        size: 18.0,
                                        color: Colors.orange,
                                      )),
                                  TextButton(
                                      onPressed: () {},
                                      child: const DefaultText(
                                        text: "Yes",
                                        size: 18.0,
                                        color: Colors.green,
                                      )),
                                ])
                          : Get.defaultDialog(
                              title: "",
                              barrierDismissible: false,
                              content: Column(
                                children: const [
                                  Icon(
                                    Icons.email,
                                    color: Colors.green,
                                    size: 120,
                                  ),
                                  DefaultText(
                                      text:
                                          "Owner didn't provide email address, try calling or chat")
                                ],
                              ),
                              actions: [
                                  TextButton(
                                      onPressed: () => Get.close(1),
                                      child: const DefaultText(
                                        text: "Okay",
                                        size: 18.0,
                                        color: Colors.orange,
                                      )),
                                ]);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.email, color: Colors.orange),
                          SizedBox(width: 10.0),
                          DefaultText(
                            text: "Email",
                            color: Colors.black87,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
