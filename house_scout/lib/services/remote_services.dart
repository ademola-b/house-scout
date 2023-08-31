import 'dart:convert';
import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:house_scout/utils/defaultText.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

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
              sharedPreferences.setBool("is_landlord", true);
              Get.offAllNamed('/ownerNavBar');
            } else {
              sharedPreferences.setBool("is_landlord", false);
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

  static Future<List<HouseOwnerProperty>?> houseOwnerProperties(
      {String? status, int? owner}) async {
    try {
      if (owner != null) {
        http.Response response = await http
            .get(Uri.parse("$baseUrl/api/properties/owner/$owner/"), headers: {
          'Authorization': "Token ${sharedPreferences.getString('token')}"
        });
        if (response.statusCode == 200) {
          return houseOwnerPropertyFromJson(response.body);
        }
      }
      if (status == null) {
        http.Response response = await http.get(ownerPropertyUrl, headers: {
          'Authorization': "Token ${sharedPreferences.getString('token')}"
        });
        if (response.statusCode == 200) {
          return houseOwnerPropertyFromJson(response.body);
        }
      } else {
        http.Response response = await http
            .get(Uri.parse("$baseUrl/api/properties/$status/"), headers: {
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

  static Future<void> postProperty(
      String name,
      String desc,
      String amount,
      String address,
      String? longitude,
      String? latitude,
      String radius,
      String status,
      {List<File?>? house_visuals}) async {
    try {
      var headers = {
        'Authorization': 'Token ${sharedPreferences.getString('token')}',
        "content-type": "multipart/form-data"
      };
      var request = http.MultipartRequest('POST', ownerPropertyUrl);
      request.fields.addAll({
        "name": name,
        "desc": desc,
        "amount": amount,
        "address": address,
        "longitude": longitude.toString(),
        "latitude": latitude.toString(),
        "radius": radius,
        "status": status
      });
      for (var visual in house_visuals!) {
        if (visual != null) {
          request.files.add(
              await http.MultipartFile.fromPath('house_visuals', visual.path));
        }
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
        Get.defaultDialog(
            title: "",
            content: Column(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Colors.orange,
                  size: 120,
                ),
                DefaultText(text: "Property Successfully Posted")
              ],
            ),
            middleText: "Property Successfully Posted",
            actions: [
              TextButton(
                  onPressed: () => Get.offNamed('/myProperties'),
                  child: const DefaultText(
                    text: "Okay",
                    size: 18.0,
                  ))
            ]);
      } else {
        controller.isClicked.value = false;
        // print(await response.stream.bytesToString());
        throw Exception("An error occurred: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.showSnackbar(
          Constants.customSnackBar(message: "Server Error: $e", tag: false));
    }
  }

  static Future<HouseOwnerProperty?> updateProperty(
    String id,
    String name,
    String desc,
    String amount,
    String address,
    String? longitude,
    String? latitude,
    String radius,
    String status, {
    List<dynamic>? house_visuals,
  }) async {
    var body = {
      "name": name,
      "desc": desc,
      "amount": amount,
      "address": address,
      "longitude": longitude.toString(),
      "latitude": latitude.toString(),
      "radius": radius,
      "status": status,
    };

    try {
      var headers = {
        'Authorization': 'Token ${sharedPreferences.getString('token')}',
        "content-type": "application/json; charset=utf-8"
      };
      var request = http.MultipartRequest('PUT', updatePropertyUrl(id));
      request.fields.addAll(body);
      for (var visual in house_visuals!) {
        if (visual != null) {
          request.files.add(
              await http.MultipartFile.fromPath('house_visuals', visual.path));
          // http.MultipartFile.fromBytes('house_visuals', visual));
        }
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print("here3: $response");
      if (response.statusCode == 200) {
        print("here4");
        print(await response.stream.bytesToString());
        // Get.defaultDialog(
        //     title: "",
        //     content: Column(
        //       children: const [
        //         Icon(
        //           Icons.check_circle,
        //           color: Colors.orange,
        //           size: 120,
        //         ),
        //         DefaultText(text: "Property Successfully Updated")
        //       ],
        //     ),
        //     actions: [
        //       TextButton(
        //           onPressed: () {
        //             Get.close(2);
        //             Get.offNamed('/myProperties');
        //           },
        //           child: const DefaultText(
        //             text: "Okay",
        //             size: 18.0,
        //           ))
        //     ]);
        controller.isClicked.value = false;
      } else {
        print("printed");
        print(await response.stream.bytesToString());
        throw Exception("An error occurred: ${response.reasonPhrase}");
      }
    } catch (e) {
      controller.isClicked.value = false;
      print("error : $e");
      Get.showSnackbar(
          Constants.customSnackBar(message: "Server Error: $e", tag: false));
    }

    return null;
  }

  static Future<void> deleteProperty(String id) async {
    try {
      http.Response response = await http.delete(updatePropertyUrl(id),
          headers: {
            "Authorization": "Token ${sharedPreferences.getString('token')}"
          });
      if (response.statusCode == 204) {
        Get.defaultDialog(
            title: "",
            content: Column(
              children: const [
                Icon(
                  Icons.info,
                  color: Colors.orange,
                  size: 120,
                ),
                DefaultText(text: "Property Successfully Deleted")
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Get.offNamed('/myProperties'),
                  child: const DefaultText(
                    text: "Okay",
                    size: 18.0,
                  ))
            ]);
      } else {
        throw Exception("An error occurred: ${response.body}");
      }
    } catch (e) {
      controller.isClicked.value = false;
      Get.showSnackbar(
          Constants.customSnackBar(message: "Server Error: $e", tag: false));
    }
  }
}
