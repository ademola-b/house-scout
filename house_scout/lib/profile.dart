import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/models/user_details_response.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultText.dart';

class ProfileController extends GetxController {
  UserDetailsResponse? userDetails;
  RxString? fname = ''.obs;
  RxString? lname = ''.obs;
  RxString? username = ''.obs;
  RxString? email = ''.obs;
  RxString? phone = ''.obs;
  RxString? gender = ''.obs;
  RxString? location = ''.obs;
  RxString? profilePix = ''.obs;

  RxBool? enabled = false.obs;

  getUserDetail() async {
    UserDetailsResponse? user = await RemoteServices.userDetails();
    if (user != null) {
      print("object");
      userDetails = user;
      fname!.value = user.firstName;
      lname!.value = user.lastName;
      username!.value = user.username;
      email!.value = user.email;
      phone!.value = user.phone;
      gender!.value = user.gender;
      location!.value = user.address;
      profilePix!.value = user.imageMem;
    } else {
      print("object is null");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserDetail();
    print("user: $userDetails");
  }
}

class Profile extends StatelessWidget {
  Profile({super.key});

  final controller = Get.put(BtnController());

  var userDetails = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.orange,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const DefaultText(
                          text: "My Profile", color: Colors.white, size: 30.0),
                      IconButton(
                          onPressed: () {
                            userDetails.enabled!.value =
                                !userDetails.enabled!.value;
                          },
                          icon: const Icon(
                            Icons.edit_note_sharp,
                            size: 40,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: Colors.white, width: 5.0),
                    ),
                    child: userDetails.profilePix == null
                        ? ClipOval(
                            child: Image.asset(
                              "assets/images/default.jpg",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipOval(
                            child: Image.memory(
                              base64Decode(userDetails.profilePix!.value),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10.0),
                  DefaultText(
                      text:
                          "${userDetails.fname!.value} ${userDetails.lname!.value}",
                      size: 20.0,
                      color: Colors.white),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    child: Obx(
                  () => Column(
                    children: [
                      Obx(() => TextFormField(
                            controller: TextEditingController(
                                text:
                                    "${userDetails.fname!.value} ${userDetails.lname!.value}"),
                            enabled: userDetails.enabled!.value,
                            decoration: const InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person_pin, color: Colors.orange),
                              labelText: 'Full Name',
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      Obx(() => TextFormField(
                            controller: TextEditingController(
                                text: userDetails.username!.value),
                            enabled: userDetails.enabled!.value,
                            decoration: const InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.orange),
                              labelText: 'Username',
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      Obx(() => TextFormField(
                          controller: TextEditingController(
                              text: userDetails.email!.value),
                          enabled: userDetails.enabled!.value,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.mail, color: Colors.orange),
                            labelText: "email",
                          ))),
                      const SizedBox(height: 10.0),
                      Obx(() => TextFormField(
                            controller: TextEditingController(
                                text: userDetails.phone!.value),
                            enabled: userDetails.enabled!.value,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.orange),
                              labelText: 'Phone Number',
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      Obx(() => TextFormField(
                            controller: TextEditingController(
                                text: userDetails.gender!.value),
                            enabled: userDetails.enabled!.value,
                            decoration: const InputDecoration(
                              prefixIcon:
                                  Icon(Icons.people, color: Colors.orange),
                              labelText: 'Gender',
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      Obx(() => TextFormField(
                            controller: TextEditingController(
                                text: userDetails.location!.value),
                            enabled: userDetails.enabled!.value,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.location_city,
                                  color: Colors.orange),
                              labelText: 'Location',
                            ),
                          )),
                      const SizedBox(height: 40.0),
                      userDetails.enabled!.value
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Obx(() => DefaultButton(
                                    onPressed: () {
                                      controller.isClicked.value = true;
                                    },
                                    textSize: 18,
                                    child: controller.circ("Update"),
                                    // text: "Login",
                                  )))
                          : const SizedBox.shrink()
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
