import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/filter_controller.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultText.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.categoriesList,
    required this.controller,
  }) : super(key: key);

  final List<String> categoriesList;
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: List.generate(
              categoriesList.length,
              (index) => Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ChoiceChip(
                      label: GestureDetector(
                        child: DefaultText(
                          text: categoriesList[index],
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Constants.containerColor,
                      selectedColor: Colors.orange,
                      selected:
                          controller.categList.contains(categoriesList[index]),
                      onSelected: (bool selected) {
                        if (selected) {
                          // add the widget to list
                          if (controller.categList
                              .contains(categoriesList[index])) {
                            controller.categList.remove(categoriesList[index]);
                            // controller._selectedIndex.value = -1;
                          } else {
                            controller.categList.add(categoriesList[index]);
                            // controller._selectedIndex.value = index;
                          }

                          print("categories: ${controller.categList}");
                        } else {
                          controller.categList.remove(categoriesList[index]);
                          print("categories: ${controller.categList}");
                        }
                      },
                    ),
                  )),
        ));
  }
}

class PropertyType extends StatelessWidget {
  const PropertyType(
      {super.key, required this.propertyTypeList, required this.controller});

  final List<String> propertyTypeList;
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: [
            for (final property in propertyTypeList)
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  label: GestureDetector(
                    child: DefaultText(
                      text: property,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Constants.containerColor,
                  selectedColor: Colors.orange,
                  selected: controller.propList.contains(property),
                  onSelected: (bool selected) {
                    if (selected) {
                      // add the widget to list
                      if (controller.propList.contains(property)) {
                        controller.propList.remove(property);
                        // controller._selectedIndex.value = -1;
                      } else {
                        controller.propList.add(property);
                        // controller._selectedIndex.value = index;
                      }

                      print("property: ${controller.propList}");
                    } else {
                      controller.propList.remove(property);
                      print("property: ${controller.propList}");
                    }
                  },
                ),
              )
          ],
        ));
  }
}

class Bathroom extends StatelessWidget {
  Bathroom({Key? key, required this.number, required this.controller})
      : super(key: key);

  final List<String> number;
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: [
            for (final num in number)
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  label: GestureDetector(
                    child: DefaultText(
                      text: num,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Constants.containerColor,
                  selectedColor: Colors.orange,
                  selected: controller.bathList.contains(num),
                  onSelected: (bool selected) {
                    if (selected) {
                      // add the widget to list
                      if (controller.bathList.contains(num)) {
                        controller.bathList.remove(num);
                      } else {
                        controller.bathList.add(num);
                      }

                      print("num: ${controller.bathList}");
                    } else {
                      controller.bathList.remove(num);
                      print("num: ${controller.bathList}");
                    }
                  },
                ),
              )
          ],
        ));
  }
}

class BedroomNumber extends StatelessWidget {
  BedroomNumber({Key? key, required this.number, required this.controller})
      : super(key: key);

  final List<String> number;
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: [
            for (final num in number)
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  label: GestureDetector(
                    child: DefaultText(
                      text: num,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Constants.containerColor,
                  selectedColor: Colors.orange,
                  selected: controller.bedNumList.contains(num),
                  onSelected: (bool selected) {
                    if (selected) {
                      // add the widget to list
                      if (controller.bedNumList.contains(num)) {
                        controller.bedNumList.remove(num);
                      } else {
                        controller.bedNumList.add(num);
                      }

                      print("num: ${controller.bedNumList}");
                    } else {
                      controller.bedNumList.remove(num);
                      print("num: ${controller.bedNumList}");
                    }
                  },
                ),
              )
          ],
        ));
  }
}

class KitchenNumber extends StatelessWidget {
  KitchenNumber({Key? key, required this.number, required this.controller})
      : super(key: key);

  final List<String> number;
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: [
            for (final num in number)
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  label: GestureDetector(
                    child: DefaultText(
                      text: num,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Constants.containerColor,
                  selectedColor: Colors.orange,
                  selected: controller.kitchenList.contains(num),
                  onSelected: (bool selected) {
                    if (selected) {
                      // add the widget to list
                      if (controller.kitchenList.contains(num)) {
                        controller.kitchenList.remove(num);
                      } else {
                        controller.kitchenList.add(num);
                      }

                      print("num: ${controller.kitchenList}");
                    } else {
                      controller.kitchenList.remove(num);
                      print("num: ${controller.kitchenList}");
                    }
                  },
                ),
              )
          ],
        ));
  }
}

class FurnishedType extends StatelessWidget {
  FurnishedType({Key? key, required this.types, required this.controller})
      : super(key: key);

  final List<String> types;
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: [
            for (final type in types)
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  label: GestureDetector(
                    child: DefaultText(
                      text: type,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Constants.containerColor,
                  selectedColor: Colors.orange,
                  selected: controller.furnishedType.contains(type),
                  onSelected: (bool selected) {
                    if (selected) {
                      // add the widget to list
                      if (controller.furnishedType.contains(type)) {
                        controller.furnishedType.remove(type);
                      } else {
                        controller.furnishedType.add(type);
                      }

                      print("type: ${controller.furnishedType}");
                    } else {
                      controller.furnishedType.remove(type);
                      print("type: ${controller.furnishedType}");
                    }
                  },
                ),
              )
          ],
        ));
  }
}

class TenantType extends StatelessWidget {
  TenantType({Key? key, required this.types, required this.controller})
      : super(key: key);

  final List<String> types;
  final FilterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: [
            for (final type in types)
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  label: GestureDetector(
                    child: DefaultText(
                      text: type,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Constants.containerColor,
                  selectedColor: Colors.orange,
                  selected: controller.tenantType.contains(type),
                  onSelected: (bool selected) {
                    if (selected) {
                      // add the widget to list
                      if (controller.tenantType.contains(type)) {
                        controller.tenantType.remove(type);
                      } else {
                        controller.tenantType.add(type);
                      }

                      print("type: ${controller.tenantType}");
                    } else {
                      controller.tenantType.remove(type);
                      print("type: ${controller.tenantType}");
                    }
                  },
                ),
              )
          ],
        ));
  }
}
