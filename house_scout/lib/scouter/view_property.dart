import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/dashboard_controller.dart';
import 'package:house_scout/utils/defaultText.dart';

class ViewProperty extends StatelessWidget {
  ViewProperty({super.key});

  var controller = List.generate(4, (index) => DashboardController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
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
                    text: "Property Details",
                    color: Colors.orange,
                    size: 25.0,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/images/bld.jpeg",
                    width: size.width,
                    height: size.height / 4,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          "assets/images/living-room.jpeg",
                          width: size.width / 4,
                          height: size.height / 9,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 20.0),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          "assets/images/living-room2.jpeg",
                          width: size.width / 4,
                          height: size.height / 9,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 20.0),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          "assets/images/bedroom.jpeg",
                          width: size.width / 4,
                          height: size.height / 9,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 20.0),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          "assets/images/kitchen.jpeg",
                          width: size.width / 4,
                          height: size.height / 9,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 20.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const DefaultText(
                text: "Price/month",
                color: Colors.orange,
                size: 25,
              ),
              const DefaultText(
                text: "2 Bedrooms, 1 Kitchen, 3 Toilets",
                color: Colors.black87,
                size: 18,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.location_on,
                    color: Colors.orange,
                  ),
                  DefaultText(
                    text: "Address",
                    color: Colors.black87,
                    size: 18,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0)),
                child: const DefaultText(
                  text: "See in Map",
                  color: Colors.black87,
                  size: 15,
                ),
              ),
              const SizedBox(height: 20.0),
              const DefaultText(
                text: "Overview",
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
              const DefaultText(
                text: "Description",
                color: Colors.orange,
                size: 20,
              ),
              // const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: const DefaultText(
                  text:
                      "Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add You can also type a keyword to search online for the video that best fits your document. To make your document look professionally produced, Word provides header, footer, cover page, and text box designs that complement each other.",
                  color: Colors.black87,
                  size: 15,
                ),
              ),
            ],
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          onPressed: () {},
          label: Row(children: [
            GestureDetector(
              onTap: () {
                Get.toNamed('/favs');
              },
              child: Column(
                children: const [
                  Icon(Icons.favorite_border, color: Colors.white),
                  DefaultText(
                    text: "Favs",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => Get.toNamed('/chat'),
              child: Column(
                children: const [
                  Icon(Icons.message, color: Colors.white),
                  DefaultText(
                    text: "Chat Owner",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => Get.toNamed('/ownerProfile'),
              child: Column(
                children: const [
                  Icon(Icons.person, color: Colors.white),
                  DefaultText(
                    text: "Profile",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
              onTap: () => Get.toNamed('/payment'),
              child: Column(
                children: const [
                  Icon(Icons.money_outlined, color: Colors.white),
                  DefaultText(
                    text: "Payment",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
