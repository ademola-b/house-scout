import 'dart:io';

import 'package:get/get.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
 

class ImageController extends GetxController {
  var imageList = List<Rx<File?>>.generate(4, (_) => Rx<File?>(null));

  Future getImage(int index, ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imgPerm = await saveImagePermanently(image.path);
      imageList[index].value = imgPerm;
      print(imageList);
    } catch (e) {
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