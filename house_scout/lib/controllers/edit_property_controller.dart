import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class EditPropertyController extends GetxController {
  var data = Get.arguments;
  var status = ''.obs;
  RxList<String> statusList = ['available', 'rented-out'].obs;
  RxList imageL = [].obs;

  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController latitude = TextEditingController();

  var filledImageList = List<dynamic>.filled(4, null).obs;
  List get getFilledImageList => filledImageList;
  var imageList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    // print(data);
    name.text = data['data']['property'].name;
    desc.text = data['data']['property'].desc;
    address.text = data['data']['property'].address;
    amount.text = data['data']['property'].amount;
    longitude.text = data['data']['property'].longitude;
    latitude.text = data['data']['property'].latitude;
    // print(data['data']['property'].houseVisuals);

    if (data['data']['property'].houseVisuals.isNotEmpty) {
      // update imagelist with backend data
      for (var element in data['data']['property'].houseVisuals) {
        imageList.add(element);
      }

      for (var i = 0; i < imageList.length; i++) {
        filledImageList[i] = imageList[i].imageMem;
      }

      print("filled - $filledImageList");
    }
  }

  

  Future getImage(int index, ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imgPerm = await saveImagePermanently(image.path);

      // Uint8List converted_image = await convertImageFileToMemory(imgPerm.path);
      filledImageList[index] = imgPerm;
      // filledImageList[index] = converted_image;
      print("im - $filledImageList");
    } catch (e) {
      print(e);
      Get.showSnackbar(Constants.customSnackBar(
          message: "An error occurred: $e", tag: false));
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }
}
