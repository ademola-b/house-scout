import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/dashboard_controller.dart';
import 'package:house_scout/controllers/property_view_controller.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:house_scout/utils/defaultText.dart';

class ViewProperty extends StatelessWidget {
  ViewProperty({super.key});

  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(data['property'].houseVisuals.length);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 20.0, left: 20.0, bottom: 40.0),
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
                  child: data['property'].houseVisuals.isEmpty
                      ? Image.asset("assets/images/bld.jpeg",
                          width: size.width,
                          height: size.height / 4,
                          fit: BoxFit.cover)
                      : Image.memory(
                          data['property'].houseVisuals[0].imageMem,
                          width: size.width,
                          height: size.height / 4,
                          fit: BoxFit.cover,
                        )),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: data['property'].houseVisuals.isEmpty
                    ? const DefaultText(
                        text: "Owner didn't upload any visual",
                        color: Colors.red,
                        size: 18.0,
                      )
                    : Row(
                        children: [
                          for (final visual
                              in data['property'].houseVisuals.skip(1))
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.memory(
                                    visual.imageMem,
                                    width: size.width / 4,
                                    height: size.height / 9,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          const SizedBox(width: 20.0),
                        ],
                      ),
              ),
              const SizedBox(height: 20.0),
              DefaultText(
                text: "${data['property'].amount}/month",
                color: Colors.orange,
                size: 25,
              ),
              const DefaultText(
                text: "2 Bedrooms, 1 Kitchen, 3 Toilets",
                color: Colors.black87,
                size: 18,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.orange,
                  ),
                  DefaultText(
                    text: "${data['property'].address}",
                    color: Colors.black87,
                    size: 18,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const DefaultText(
                      text: "See in Map",
                      color: Colors.black87,
                      size: 15,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: DefaultText(
                      text: "${data['property'].status}",
                      color: data['property'].status == 'available'
                          ? Colors.green
                          : Colors.red,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const DefaultText(
                text: "Overview",
                color: Colors.orange,
                size: 20,
              ),
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
                child: DefaultText(
                  text: "${data['property'].desc}",
                  color: Colors.black87,
                  size: 15,
                ),
              ),

              // const SizedBox(height: 20.0),
            ],
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: data['property'].user.isLandlord
            ? FloatingActionButton.extended(
                onPressed: () {},
                label: Row(children: [
                  GestureDetector(
                    onTap: () =>
                        Get.toNamed('/editProp', arguments: {'data': data}),
                    child: Column(
                      children: const [
                        Icon(Icons.edit, color: Colors.white),
                        DefaultText(
                          text: "Edit",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "",
                          content: Column(
                            children: const [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 120,
                              ),
                              DefaultText(
                                  text:
                                      "Are you sure you want to delete this property ?")
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
                                onPressed: () => RemoteServices.deleteProperty(
                                    data['property'].houseId),
                                child: const DefaultText(
                                  text: "Yes",
                                  size: 18.0,
                                  color: Colors.red,
                                )),
                          ]);
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.delete_forever, color: Colors.white),
                        DefaultText(
                          text: "Delete",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            : FloatingActionButton.extended(
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
