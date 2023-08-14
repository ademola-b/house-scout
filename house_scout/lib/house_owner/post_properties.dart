import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';

import '../utils/defaultText.dart';

class PostProperty extends StatelessWidget {
  PostProperty({super.key});

  final controller = Get.put(BtnController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const DefaultText(
          text: "Post Property",
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DefaultText(
                          text: "Add Photo/Video",
                          color: Colors.black,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(height: 20.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                    4,
                                    (index) => GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: size.width / 4,
                                              height: size.height / 9,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 50,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        )),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                obscureText: false,
                label: "Name",
              ),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                obscureText: false,
                maxLines: 5,
                label: "Description",
                icon: Icons.description,
              ),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                obscureText: false,
                icon: Icons.numbers,
                label: "Amount Per Month",
                keyboardInputType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                obscureText: false,
                icon: Icons.location_city,
                label: "Address",
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey, width: 1.0)),
                child: ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return Container(
                            height: size.height / 2,
                            // width: size.width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100.0),
                                    topRight: Radius.circular(100.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(() => DefaultButton(
                                          onPressed: () {
                                            // controller.isClicked.value = true;
                                          },
                                          textSize: 18,
                                          child: controller
                                              .circ("Get Coordinates")))
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  const DefaultTextFormField(
                                    obscureText: false,
                                    icon: Icons.location_on_outlined,
                                    hintText: "Longitude",
                                    label: "Longitude",
                                  ),
                                  const SizedBox(height: 20.0),
                                  const DefaultTextFormField(
                                    obscureText: false,
                                    icon: Icons.location_on_outlined,
                                    hintText: "Latitude",
                                    label: "Latitude",
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: size.width,
                                    child: Obx(() => DefaultButton(
                                        onPressed: () {
                                          // controller.isClicked.value = true;
                                        },
                                        textSize: 18,
                                        child: controller.circ("Submit"))),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  leading: const Icon(Icons.near_me),
                  title: const DefaultText(text: "Location"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                  width: size.width,
                  child: Obx(() => DefaultButton(
                      onPressed: () {
                        // controller.isClicked.value = true;
                      },
                      textSize: 18,
                      child: controller.circ("Post")))),
            ],
          ),
        ),
      ),
    );
  }
}
