import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/dashboard_controller.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';

class NearbyProperties extends StatelessWidget {
  NearbyProperties({super.key});
  // var controller = List.generate(4, (index) => Get.put(DashboardController()));
  var controller = List.generate(10, (index) => DashboardController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                    text: "Nearby Properties",
                    size: 20,
                    color: Colors.orange,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              const DefaultText(
                text: "Search for Property",
                color: Constants.primaryColor,
                size: 18,
              ),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                obscureText: false,
                hintText: "Search for property",
                icon: Icons.search,
                borderRadius: 30.0,
                fontSize: 15,
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: List.generate(
                        10,
                        (index) => Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 6.0)
                                  ]),
                              width: size.width / 2.5,
                              height: size.width / 1.8,
                              child: Column(
                                children: [
                                  Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        "assets/images/default.jpg",
                                        width: size.width,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Obx(() => GestureDetector(
                                              onTap: () => controller[index]
                                                  .changeFavIcon(),
                                              child:
                                                  controller[index].icon.value,
                                            )),
                                      ),
                                    )
                                  ]),
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: DefaultText(
                                      text: "Price/month",
                                      color: Colors.orange,
                                      weight: FontWeight.bold,
                                      size: 15.0,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: DefaultText(
                                      text: "Name",
                                      weight: FontWeight.bold,
                                      size: 15.0,
                                      align: TextAlign.left,
                                    ),
                                  ),
                                  const DefaultText(
                                    text: "Address",
                                    weight: FontWeight.bold,
                                    size: 15.0,
                                  ),
                                ],
                              ),
                            ))),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
