import 'package:flutter/material.dart';

class Constants {
  static const Color primaryColor = Color(0xFF382201);
  static const Color containerColor = Color.fromARGB(255, 189, 162, 122);


  static String? validator(String? value){
    if (value == null || value.isEmpty) {
      return "This Field is required";
    }
    return null;
  }
}
