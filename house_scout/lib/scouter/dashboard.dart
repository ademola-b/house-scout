import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/dashboard_controller.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';

class FilterController extends GetxController {
  RxInt _selectedIndex = 1.obs;
  RxBool selected = false.obs;

  var iconColor = Colors.white.obs;

  iconColorChange() {
    if (selected.value) {
      iconColor.value = Colors.white;
    }
  }
}

class ScouterDashboard extends StatelessWidget {
  ScouterDashboard({super.key});
  // var controller = List.generate(4, (index) => Get.put(DashboardController()));
  var controller = List.generate(4, (index) => DashboardController());
  var filterController = FilterController();

  final List<Widget> _icons = [
    const Icon(Icons.filter_alt_outlined, color: Colors.white),
    const DefaultText(text: "All", color: Colors.white, size: 18.0),
    const DefaultText(text: "Rent", color: Colors.white, size: 18.0),
    const DefaultText(text: "Lease", color: Colors.white, size: 18.0),
  ];

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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(
                          color: Constants.containerColor, width: 5.0),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/default.jpg",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chat,
                        size: 40,
                        color: Constants.primaryColor,
                      )),
                  const SizedBox(width: 20),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        size: 40,
                        color: Constants.primaryColor,
                      )),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DefaultText(
                    text: "Nearby Properties",
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/nearbyProperties'),
                    child: const DefaultText(
                      text: "See More",
                      size: 15,
                      color: Colors.orange,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Obx(() => Wrap(
                    children: List.generate(
                        4,
                        (index) => Container(
                              // decoration: const BoxDecoration(boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.grey,
                              //       offset: Offset(0.0, 0.5),
                              //       blurRadius: 6.0)
                              // ]),
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ChoiceChip(
                                label: GestureDetector(
                                  child: _icons[index],
                                ),
                                backgroundColor: Constants.containerColor,
                                // filterController.backgroundColorChange(),
                                selectedColor: Colors.orange,
                                selected:
                                    filterController._selectedIndex.value ==
                                        index,
                                onSelected: (bool selected) {
                                  if (selected) {
                                    filterController._selectedIndex.value =
                                        index;
                                    filterController.selected.value = true;
                                    // !filterController.selected.value;
                                    print(filterController._selectedIndex);
                                    if (filterController._selectedIndex.value ==
                                        0) {
                                      Get.toNamed('/filter');
                                    }
                                  }
                                },
                              ),
                            )),
                  )),
              const SizedBox(height: 20.0),
              Center(
                child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: List.generate(
                        4,
                        (index) => GestureDetector(
                              onTap: () => Get.toNamed('/viewProperty'),
                              child: Container(
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          "assets/images/bld.jpeg",
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
                                                child: controller[index]
                                                    .icon
                                                    .value,
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
                              ),
                            ))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/balcony.svg",
                      width: 180,
                      height: 180,
                    ),
                  ),
                  const DefaultText(
                    text:
                        "No Nearby Property Availabe for rent/lease at the moment",
                    size: 18,
                    color: Colors.orange,
                    align: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
