import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/dashboard_controller.dart';
import 'package:house_scout/services/remote_services.dart';
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
              const SizedBox(
                child: DefaultTextFormField(
                  obscureText: false,
                  hintText: "Search for property",
                  icon: Icons.search,
                  borderRadius: 30.0,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: FutureBuilder(
                  future: RemoteServices.houseOwnerProperties(),
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
                            text:
                                "No Nearby Property Availabe for rent/lease at the moment",
                            size: 18,
                            color: Colors.orange,
                            align: TextAlign.center,
                          ),
                        ],
                      );
                    } else if (snapshot.hasData) {
                      var data = snapshot.data;
                      return Wrap(
                          spacing: 20.0,
                          runSpacing: 20.0,
                          children: List.generate(
                              data!.length,
                              (index) => GestureDetector(
                                    onTap: () => Get.toNamed('/viewProperty',
                                        arguments: {'property': data[index]}),
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
                                                          .houseVisuals![0]
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
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Obx(() =>
                                                    GestureDetector(
                                                      onTap: () =>
                                                          controller[index]
                                                              .changeFavIcon(),
                                                      child: controller[index]
                                                          .icon
                                                          .value,
                                                    )),
                                              ),
                                            )
                                          ]),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: DefaultText(
                                              text:
                                                  "${data[index].amount}/month",
                                              color: Colors.orange,
                                              weight: FontWeight.bold,
                                              size: 15.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
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
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
