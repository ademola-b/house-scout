import 'dart:convert';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:house_scout/controllers/login_controller.dart';
import 'package:house_scout/controllers/usertype_controller.dart';
import 'package:house_scout/main.dart';
import 'package:house_scout/models/house_owner_prop.dart';
import 'package:house_scout/models/login_response.dart';
import 'package:house_scout/models/registration_response.dart';
import 'package:house_scout/models/user_details_response.dart';
import 'package:house_scout/services/urls.dart';
import 'package:house_scout/utils/constants.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static final controller = Get.put(BtnController());

  static Future<RegistrationResponse?> register(
      String? username, String? email, String? password, bool? userType) async {
    final regController = Get.put(UserTypeController());
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
            message: "Account Successfully Created, Login Now", tag: true));
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
          regController.isClicked.value = false;
        } else if (responseData['email'] != null) {
          String output = '';
          for (var element in responseData['email']) {
            output += element + "\n";
          }
          Get.showSnackbar(
              Constants.customSnackBar(message: output, tag: false));
          regController.isClicked.value = false;
        } else if (responseData['password1'] != null) {
          String output = '';
          for (var element in responseData['password1']) {
            output += element + "\n";
          }
          Get.showSnackbar(
              Constants.customSnackBar(message: output, tag: false));
          regController.isClicked.value = false;
        } else if (responseData['password2'] != null) {
          String output = '';
          for (var element in responseData['password2']) {
            output += element + "\n";
          }
          Get.showSnackbar(
              Constants.customSnackBar(message: output, tag: false));
          regController.isClicked.value = false;
        }
      }
    } catch (e) {
      Get.showSnackbar(Constants.customSnackBar(
          message: "An error occurred: $e", tag: false));
      regController.isClicked.value = false;
    }

    return null;
  }

  static Future<UserDetailsResponse?> userDetails() async {
    try {
      http.Response response = await http.get(userurl, headers: {
        'Authorization': "Token ${sharedPreferences.getString('token')}"
      });
      if (response.statusCode == 200) {
        return userDetailsResponseFromJson(response.body);
      } else {
        throw Exception('Failed to get user details');
      }
    } catch (e) {
      Get.showSnackbar(Constants.customSnackBar(
          message: "An error occurred: $e", tag: false));
    }
    return null;
  }

  static Future<LoginResponse?> login(
      String? username, String? password) async {
    try {
      http.Response response = await http
          .post(loginUrl, body: {'username': username, 'password': password});
      var responseData = jsonDecode(response.body);
      if (responseData != null) {
        if (responseData['key'] != null) {
          sharedPreferences.setString('token', responseData['key']);
          UserDetailsResponse? userDetail = await RemoteServices.userDetails();
          if (userDetail != null) {
            if (userDetail.isLandlord) {
              Get.offAllNamed('/ownerNavBar');
            } else {
              Get.offAllNamed('/scouterNavBar');
            }
          } else {
            Get.showSnackbar(Constants.customSnackBar(
                message: "User not found", tag: false));
          }
        } else if (responseData['non_field_errors'] != null) {
          RemoteServices.controller.isClicked.value = false;
          Get.showSnackbar(Constants.customSnackBar(
              message: "${responseData['non_field_errors']}", tag: false));
        }
      }
    } catch (e) {
      RemoteServices.controller.isClicked.value = false;

      Get.showSnackbar(Constants.customSnackBar(
          message: "An error occurred: $e", tag: false));
    }
    return null;
  }

  static Future<List<HouseOwnerProperty>?> houseOwnerProperties({String? status}) async {
    try {
      if(status==null){
        http.Response response = await http.get(ownerPropertyUrl, headers: {
        'Authorization': "Token ${sharedPreferences.getString('token')}"
      });
      if (response.statusCode == 200) {
        return houseOwnerPropertyFromJson(response.body);
      }
      } else{
        http.Response response = await http.get(Uri.parse("$baseUrl/api/properties/$status/"), headers: {
        'Authorization': "Token ${sharedPreferences.getString('token')}"
      });
      if (response.statusCode == 200) {
        return houseOwnerPropertyFromJson(response.body);
      }

      }
      
    } catch (e) {
      Get.showSnackbar(
          Constants.customSnackBar(message: "Server Error: $e", tag: false));
    }

    return [];
  }


}
