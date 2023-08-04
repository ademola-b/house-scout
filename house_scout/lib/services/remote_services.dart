import 'dart:convert';

// import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:house_scout/models/registration_response.dart';
import 'package:house_scout/services/urls.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static Future<RegistrationResponse?> register(
      String? username, String? email, String? password, bool? userType) async {
    try {
      http.Response response = await http.post(
        registerUrl,
        body: jsonEncode({
          'username': username,
          'email': email,
          'password1': password,
          'password2': password,
          'is_landlord': userType
        }),
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 201) {
        Get.showSnackbar(Constants.customSnackBar(
            message: "Successfully Created", tag: true));
        Get.offNamed('/login');
      } else {
        var responseData = jsonDecode(response.body);
        if (responseData['username'] != null) {
          String output = '';
          for (var element in responseData['username']) {
            output += element + "\n";
          }
          Get.showSnackbar(
              Constants.customSnackBar(message: output, tag: false));
        } else if (responseData['email'] != null) {
          String output = '';
          for (var element in responseData['email']) {
            output += element + "\n";
          }
          Get.showSnackbar(
              Constants.customSnackBar(message: output, tag: false));
        } else if (responseData['password1'] != null) {
          String output = '';
          for (var element in responseData['password1']) {
            output += element + "\n";
          }
          Get.showSnackbar(
              Constants.customSnackBar(message: output, tag: false));
        } else if (responseData['password2'] != null) {
          String output = '';
          for (var element in responseData['password2']) {
            output += element + "\n";
          }
          Get.showSnackbar(
              Constants.customSnackBar(message: output, tag: false));
        }
      }
    } catch (e) {
      Get.showSnackbar(Constants.customSnackBar(
          message: "Account Successfully Created, Login Now", tag: true));
    }

    return null;
  }
}
