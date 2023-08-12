import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/filter_controller.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultText.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';
import 'package:house_scout/utils/filter_pref.dart';

class Filter extends StatelessWidget {
  Filter({super.key});

  var controller = FilterController();
  var btnController = BtnController();

  List<String> categoriesList = ["rent", "lease"];
  List<String> propertyTypeList = ["flat", "condos", "townhouse", "individual"];
  List<String> bedNumberList = ["1", "2", "3", "3+"];
  List<String> bathNumberList = ["1", "2", "3", "3+"];
  List<String> kitchenNumberList = ["1", "2", "3", "3+"];
  List<String> furnishList = [
    "unfurnished",
    "semi-furnished",
    "fully-furnished"
  ];
  List<String> tenantList = ["family", "bachelor"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.orange,
                      ),
                    ),
                    const DefaultText(
                      text: "Filter",
                      color: Colors.orange,
                      size: 20.0,
                      weight: FontWeight.bold,
                    ),
                    GestureDetector(
                      onTap: () => controller.clearAll(),
                      child: const DefaultText(
                          text: "Clear All ", color: Colors.orange, size: 20.0),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                const DefaultText(
                    text: "Categories", color: Colors.orange, size: 18.0),
                // const SizedBox(height: 10.0),
                Categories(
                    categoriesList: categoriesList, controller: controller),
                const SizedBox(height: 10.0),
                const DefaultText(
                    text: "Budget", color: Colors.orange, size: 18.0),
                const DefaultTextFormField(
                    obscureText: false,
                    icon: Icons.numbers,
                    hintText: "Enter least amount"),
                const SizedBox(height: 10.0),
                const DefaultText(
                    text: "Property Type", color: Colors.orange, size: 18.0),
                PropertyType(
                    propertyTypeList: propertyTypeList, controller: controller),
                const DefaultText(
                    text: "Bedroom Number", color: Colors.orange, size: 18.0),
                BedroomNumber(number: bedNumberList, controller: controller),
                const DefaultText(
                    text: "Bathroom", color: Colors.orange, size: 18.0),
                Bathroom(number: bathNumberList, controller: controller),
                const DefaultText(
                    text: "Kitchen", color: Colors.orange, size: 18.0),
                KitchenNumber(
                    number: kitchenNumberList, controller: controller),
                const DefaultText(
                    text: "Furnished Type", color: Colors.orange, size: 18.0),
                FurnishedType(types: furnishList, controller: controller),
                const DefaultText(
                    text: "Tenant Type", color: Colors.orange, size: 18.0),
                TenantType(types: tenantList, controller: controller),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DefaultButton(
                    onPressed: () {
                      Get.toNamed('/searchResult');
                      btnController.isClicked.value = true;
                    },
                    textSize: 18.0,
                    child: btnController.circ("View Result"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
