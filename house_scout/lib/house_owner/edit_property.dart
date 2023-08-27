import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/edit_property_controller.dart';
import 'package:house_scout/controllers/image_controller.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:house_scout/utils/defaultButton.dart';
import 'package:house_scout/utils/defaultDropdown.dart';
import 'package:house_scout/utils/defaultTextFormField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/defaultText.dart';

class EditProperty extends StatelessWidget {
  EditProperty({super.key});
  final controller = Get.put(BtnController());
  var data = Get.arguments;

  final edController = Get.put(EditPropertyController());

  final edImageControllers =
      List.generate(EditPropertyController().filledImageList.length, (index) {
    return Get.put(EditPropertyController());
  });

  // final edImageControllers =
  //     List.generate(EditPropertyController().filledImageList.length, (index) {
  //   return Get.put(ImageController());
  // });

  final _form = GlobalKey<FormState>();
  final _form1 = GlobalKey<FormState>();

  late String _name, _desc, _amt, _addr;
  String? _long, _lat;

  var dropdownvalue;

  Future<File> convertImageMemoryToFile(
      Uint8List imageMemory, String outputPath) async {
    File imageFile = File(outputPath);
    try {
      await imageFile.writeAsBytes(imageMemory);
      print('Image memory converted to file: $imageFile');
    } catch (e) {
      print('Error converting image memory to file: $e');
    }
    return imageFile;
  }

  _updateProperty(String id, String status) async {
    var isValid = _form.currentState!.validate();
    if (!isValid) return;

    List<dynamic> imageList = [];
    List<dynamic> indexes = [];

    for (var i = 0; i < edImageControllers[0].getFilledImageList.length; i++) {
      if (edImageControllers[0].filledImageList[i] is File) {
        imageList.add(edImageControllers[0].filledImageList[i]);
        indexes.add(i);
      } else {
        if (edImageControllers[0].filledImageList[i] != null) {
          final dir = await getExternalStorageDirectory();
          final outputPath =
              "/data/user/0/com.example.house_scout/app_flutter/img$i.jpg";

          File imageFile = File(outputPath);
          if (!await imageFile.exists()) {
            imageFile.create(recursive: true);
          }

          imageFile.writeAsBytes(edImageControllers[0].filledImageList[i]);
          imageList.add(imageFile);
        indexes.add(i);

          // imageFile.writeAsBytes(edImageControllers[0].filledImageList[i]));
        }
      }
    }

    // print("imagessss - $imageList");

    _form.currentState!.save();
    controller.isClicked.value = true;

    await RemoteServices.updateProperty(
        id, _name, _desc, _amt, _addr, _long, _lat, "50", status,
        house_visuals: imageList);
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
    // print("data - ${data['data']['property'].houseId}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const DefaultText(
          text: "Edit Property",
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
                            text: "Change Photo",
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(height: 20.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Row(
                              children: [
                                Wrap(
                                  children: List.generate(4,
                                      // imageController.imageList.length,
                                      (index) {
                                    final control = edImageControllers[index];

                                    return Obx(() => GestureDetector(
                                          onTap: () {
                                            print("index clicked: $index");
                                            control.getImage(
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
                                                child: edController
                                                                .filledImageList[
                                                            index] ==
                                                        null
                                                    ? const Icon(
                                                        Icons.add,
                                                        size: 50,
                                                        color: Colors.orange,
                                                      )
                                                    : edController
                                                                .filledImageList[
                                                            index] is File
                                                        ? Image.file(
                                                            edController
                                                                    .filledImageList[
                                                                index],
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.memory(
                                                            edController
                                                                    .filledImageList[
                                                                index],
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
                  text: edController.name,
                  obscureText: false,
                  label: "Name",
                  validator: Constants.validator,
                  onSaved: (newValue) => _name = newValue!,
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  text: edController.desc,
                  obscureText: false,
                  maxLines: 5,
                  label: "Description",
                  icon: Icons.description,
                  validator: Constants.validator,
                  onSaved: (newValue) => _desc = newValue!,
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  text: edController.amount,
                  obscureText: false,
                  icon: Icons.numbers,
                  label: "Amount Per Month",
                  keyboardInputType: TextInputType.number,
                  validator: Constants.validator,
                  onSaved: (newValue) => _amt = newValue!,
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  text: edController.address,
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
                                                text: edController.longitude,
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
                                                text: edController.latitude,
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
                Obx(() => DefaultDropDown(
                      onChanged: (newVal) {
                        dropdownvalue = newVal;
                        edController.status.value = newVal;
                      },
                      dropdownMenuItemList: edController.statusList
                          .map((item) => DropdownMenuItem(
                              value: item, child: DefaultText(text: item)))
                          .toList(),
                      text: "Status",
                      value: data['data']['property'].status,
                      validator: (value) {
                        if (value == null) {
                          return "field is required";
                        }

                        return null;
                      },
                      onSaved: (newVal) {
                        // print("newval - $newVal");
                        edController.status.value = newVal;
                        // print(edController.status.value);
                      },
                    )),
                const SizedBox(height: 20.0),
                SizedBox(
                    width: size.width,
                    child: Obx(() => DefaultButton(
                        onPressed: () {
                          _updateProperty(data['data']['property'].houseId,
                              edController.status.value);
                          print("status-${edController.status.value}");
                        },
                        textSize: 18,
                        child: controller.circ("Update")))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
