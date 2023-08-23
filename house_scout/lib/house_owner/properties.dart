import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/dashboard_controller.dart';
import 'package:house_scout/controllers/filter_controller.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';

class MyProperties extends StatelessWidget {
  MyProperties({super.key});

  final List<Widget> filterPrefs = [
    const DefaultText(text: "All", color: Colors.white, size: 18.0),
    const DefaultText(text: "Rented Out", color: Colors.white, size: 18.0),
    const DefaultText(text: "Available", color: Colors.white, size: 18.0),
  ];

  var filterController = FilterController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    text: "My Properties",
                    size: 20,
                    color: Colors.orange,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Obx(() => Wrap(
                    children: List.generate(
                        3,
                        (index) => Container(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ChoiceChip(
                                label: GestureDetector(
                                  child: filterPrefs[index],
                                ),
                                backgroundColor: Constants.containerColor,
                                selectedColor: Colors.orange,
                                selected:
                                    filterController.selectedIndex.value ==
                                        index,
                                onSelected: (bool selected) {
                                  if (selected) {
                                    filterController.selectedIndex.value =
                                        index;
                                    filterController.selected.value = true;
                                    print(filterController.selectedIndex);
                                  }
                                },
                              ),
                            )),
                  )),
              const SizedBox(height: 20.0),
              Obx(
                () => Center(
                  child: filterController.selectedIndex == 1
                      ? FutureBuilder(
                          future: RemoteServices.houseOwnerProperties(
                              status: "rented-out"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.isEmpty) {
                              return Column(
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
                                    text: "None of your property is rented",
                                    size: 18,
                                    color: Colors.orange,
                                    align: TextAlign.center,
                                  ),
                                ],
                              );
                            } else if (snapshot.hasData) {
                              var data = snapshot.data;
                              var controller = List.generate(data!.length,
                                  (index) => DashboardController());

                              return Wrap(
                                  spacing: 20.0,
                                  runSpacing: 20.0,
                                  children: List.generate(
                                      data!.length,
                                      (index) => GestureDetector(
                                            onTap: () => Get.toNamed(
                                                '/viewProperty',
                                                arguments: {
                                                  'property': data[index]
                                                }),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  border: Border.all(
                                                      style: BorderStyle.solid,
                                                      color: Colors.white),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        offset:
                                                            Offset(0.0, 1.0),
                                                        blurRadius: 6.0)
                                                  ]),
                                              width: size.width / 2.5,
                                              height: size.width / 1.8,
                                              child: Column(
                                                children: [
                                                  Stack(children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: data[index]
                                                              .houseVisuals!
                                                              .isEmpty
                                                          ? Image.asset(
                                                              "assets/images/bld.jpeg",
                                                              width: size.width,
                                                              height: 110,
                                                              fit: BoxFit.cover)
                                                          : Image.memory(
                                                              data[index]
                                                                  .houseVisuals![
                                                                      0]
                                                                  .imageMem,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child: Obx(() =>
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  controller[
                                                                          index]
                                                                      .changeFavIcon(),
                                                              child: controller[
                                                                      index]
                                                                  .icon
                                                                  .value,
                                                            )),
                                                      ),
                                                    )
                                                  ]),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: DefaultText(
                                                      text: data[index].amount,
                                                      color: Colors.orange,
                                                      weight: FontWeight.bold,
                                                      size: 15.0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: DefaultText(
                                                      text: data[index].name,
                                                      weight: FontWeight.bold,
                                                      size: 15.0,
                                                      align: TextAlign.left,
                                                    ),
                                                  ),
                                                  DefaultText(
                                                    text: data[index].address,
                                                    weight: FontWeight.bold,
                                                    size: 15.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )));
                            }

                            return const CircularProgressIndicator(
                                color: Colors.orange);
                          },
                        )
                      : filterController.selectedIndex == 2
                          ? FutureBuilder(
                              future: RemoteServices.houseOwnerProperties(
                                  status: "available"),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isEmpty) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            "You have no property availabe for rent/lease at the moment",
                                        size: 18,
                                        color: Colors.orange,
                                        align: TextAlign.center,
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasData) {
                                  var data = snapshot.data;
                                  var controller = List.generate(data!.length,
                                      (index) => DashboardController());
                                  return Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: List.generate(
                                          data!.length,
                                          (index) => GestureDetector(
                                                onTap: () => Get.toNamed(
                                                    '/viewProperty',
                                                    arguments: {
                                                      'property': data[index]
                                                    }),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          color: Colors.white),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(
                                                                0.0, 1.0),
                                                            blurRadius: 6.0)
                                                      ]),
                                                  width: size.width / 2.5,
                                                  height: size.width / 1.8,
                                                  child: Column(
                                                    children: [
                                                      Stack(children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: data[index]
                                                                  .houseVisuals!
                                                                  .isEmpty
                                                              ? Image.asset(
                                                                  "assets/images/bld.jpeg",
                                                                  width: size
                                                                      .width,
                                                                  height: 110,
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Image.memory(
                                                                  data[index]
                                                                      .houseVisuals![
                                                                          0]
                                                                      .imageMem,
                                                                  width: size
                                                                      .width,
                                                                  height: 110,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                        Positioned(
                                                          top: 5,
                                                          right: 5,
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                            child: Obx(() =>
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      controller[
                                                                              index]
                                                                          .changeFavIcon(),
                                                                  child: controller[
                                                                          index]
                                                                      .icon
                                                                      .value,
                                                                )),
                                                          ),
                                                        )
                                                      ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: DefaultText(
                                                          text: data[index]
                                                              .amount,
                                                          color: Colors.orange,
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15.0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: DefaultText(
                                                          text:
                                                              data[index].name,
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15.0,
                                                          align: TextAlign.left,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: DefaultText(
                                                          text: data[index]
                                                              .address,
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )));
                                }

                                return const CircularProgressIndicator(
                                    color: Colors.orange);
                              },
                            )
                          : FutureBuilder(
                              future: RemoteServices.houseOwnerProperties(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isEmpty) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            "You have no property availabe for rent/lease at the moment",
                                        size: 18,
                                        color: Colors.orange,
                                        align: TextAlign.center,
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasData) {
                                  var data = snapshot.data;
                                  var controller = List.generate(data!.length,
                                      (index) => DashboardController());
                                  return Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: List.generate(
                                          data!.length,
                                          (index) => GestureDetector(
                                                onTap: () => Get.toNamed(
                                                    '/viewProperty',
                                                    arguments: {
                                                      'property': data[index]
                                                    }),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          color: Colors.white),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(
                                                                0.0, 1.0),
                                                            blurRadius: 6.0)
                                                      ]),
                                                  width: size.width / 2.5,
                                                  height: size.width / 1.8,
                                                  child: Column(
                                                    children: [
                                                      Stack(children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: data[index]
                                                                  .houseVisuals!
                                                                  .isEmpty
                                                              ? Image.asset(
                                                                  "assets/images/bld.jpeg",
                                                                  width: size
                                                                      .width,
                                                                  height: 110,
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Image.memory(
                                                                  data[index]
                                                                      .houseVisuals![
                                                                          0]
                                                                      .imageMem,
                                                                  width: size
                                                                      .width,
                                                                  height: 110,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                        Positioned(
                                                          top: 5,
                                                          right: 5,
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                            child: Obx(() =>
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      controller[
                                                                              index]
                                                                          .changeFavIcon(),
                                                                  child: controller[
                                                                          index]
                                                                      .icon
                                                                      .value,
                                                                )),
                                                          ),
                                                        )
                                                      ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: DefaultText(
                                                          text: data[index]
                                                              .amount,
                                                          color: Colors.orange,
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15.0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: DefaultText(
                                                          text:
                                                              data[index].name,
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15.0,
                                                          align: TextAlign.left,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: DefaultText(
                                                          text: data[index]
                                                              .address,
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )));
                                }

                                return const CircularProgressIndicator(
                                    color: Colors.orange);
                              },
                            ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
