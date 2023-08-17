import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/image_controller.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/defaultText.dart';

class PostProperty extends StatelessWidget {
  PostProperty({super.key});

  final controller = Get.put(BtnController());
  // final imageController = Get.put(ImageController());
  final imageControllers = List.generate(4, (index) {
    return Get.put(ImageController());
  });

  final _form = GlobalKey<FormState>();
  final _form1 = GlobalKey<FormState>();
  late String _name, _desc, _amt, _addr, _long, _lat;

  _post() {
    var isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();
  }

  _locationForm() {
    var isValid = _form1.currentState!.validate();
    if (!isValid) return;

    _form1.currentState!.save();
    controller.locationTileStatus.value = const Icon(
      Icons.check_rounded,
      color: Colors.green,
    );
    Get.close(1);
  }

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
        child: Form(
          key: _form,
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
                          ),
                          const SizedBox(height: 20.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Row(
                              children: [
                                Wrap(
                                  children:
                                      List.generate(imageControllers.length,
                                          // imageController.imageList.length,
                                          (index) {
                                    final controller = imageControllers[index];
                                    // final controller = Get.put(ImageController(),
                                    //     tag: 'image$index');
                                    return Obx(() => GestureDetector(
                                          onTap: () {
                                            controller.getImage(
                                                index, ImageSource.gallery);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: size.width / 4,
                                                height: size.height / 9,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: controller
                                                            .imageList[index]
                                                            .value ==
                                                        null
                                                    ? const Icon(
                                                        Icons.add,
                                                        size: 50,
                                                        color: Colors.orange,
                                                      )
                                                    : Image.file(
                                                        controller
                                                            .imageList[index]
                                                            .value!,
                                                        fit: BoxFit.cover,
                                                      )),
                                          ),
                                        ));
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  obscureText: false,
                  label: "Name",
                  validator: Constants.validator,
                  onSaved: (newValue) => _name = newValue!,
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  obscureText: false,
                  maxLines: 5,
                  label: "Description",
                  icon: Icons.description,
                  validator: Constants.validator,
                  onSaved: (newValue) => _desc = newValue!,
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  obscureText: false,
                  icon: Icons.numbers,
                  label: "Amount Per Month",
                  keyboardInputType: TextInputType.number,
                  validator: Constants.validator,
                  onSaved: (newValue) => _amt = newValue!,
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  obscureText: false,
                  icon: Icons.location_city,
                  label: "Address",
                  validator: Constants.validator,
                  onSaved: (newValue) => _addr = newValue!,
                ),
                const SizedBox(height: 20.0),
                Obx(() => Container(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                        Form(
                                          key: _form1,
                                          child: Column(
                                            children: [
                                              DefaultTextFormField(
                                                obscureText: false,
                                                icon:
                                                    Icons.location_on_outlined,
                                                hintText: "Longitude",
                                                label: "Longitude",
                                                validator: Constants.validator,
                                                onSaved: (newValue) =>
                                                    _long = newValue!,
                                              ),
                                              const SizedBox(height: 20.0),
                                              DefaultTextFormField(
                                                obscureText: false,
                                                icon:
                                                    Icons.location_on_outlined,
                                                hintText: "Latitude",
                                                label: "Latitude",
                                                validator: Constants.validator,
                                                onSaved: (newValue) =>
                                                    _lat = newValue!,
                                              ),
                                              // const Spacer(),
                                              const SizedBox(height: 20.0),
                                              SizedBox(
                                                width: size.width,
                                                child: Obx(() => DefaultButton(
                                                    onPressed: () {
                                                      // controller.isClicked.value = true;
                                                      _locationForm();
                                                    },
                                                    textSize: 18,
                                                    child: controller
                                                        .circ("Submit"))),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        leading: const Icon(Icons.near_me),
                        title: const DefaultText(text: "Location"),
                        trailing: controller.locationTileStatus.value,
                      ),
                    )),
                const SizedBox(height: 20.0),
                SizedBox(
                    width: size.width,
                    child: Obx(() => DefaultButton(
                        onPressed: () {
                          // controller.isClicked.value = true;
                          _post();
                          print("cli");
                        },
                        textSize: 18,
                        child: controller.circ("Post")))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
