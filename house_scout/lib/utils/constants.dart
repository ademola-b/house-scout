import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/utils/defaultText.dart';

class Constants {
  static const Color primaryColor = Color(0xFF382201);
  static const Color containerColor = Color.fromARGB(255, 189, 162, 122);

  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This Field is required";
    }
    return null;
  }

  static customSnackBar({String? title, String? message, required bool tag}) {
    return GetSnackBar(
        title: title,
        // message: message,
        messageText: DefaultText(
          text: message,
          color: Colors.white,  
        ),
        backgroundColor: tag ? Colors.green : Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: EdgeInsets.all(20.0),
        borderRadius: 10);
  }
}
