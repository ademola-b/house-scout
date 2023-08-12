import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';

class OwnerProfile extends StatelessWidget {
  const OwnerProfile({super.key});

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
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/default.jpg",
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
                      text: "Full Name",
                      color: Colors.grey[900],
                      size: 20.0,
                    ),
                  ),
                  Positioned(
                    bottom: -130,
                    child: DefaultText(
                      text: "Address",
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
                      children: const [
                        DefaultText(
                          text: "Total Posts",
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
                          text: "Total Posts",
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
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                  Container(
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
                  Container(
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
