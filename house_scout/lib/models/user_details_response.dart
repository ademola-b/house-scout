// To parse this JSON data, do
//
//     final userDetailsResponse = userDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

UserDetailsResponse userDetailsResponseFromJson(String str) =>
    UserDetailsResponse.fromJson(json.decode(str));

String userDetailsResponseToJson(UserDetailsResponse data) =>
    json.encode(data.toJson());

class UserDetailsResponse {
  int pk;
  String username;
  String email;
  String firstName;
  String lastName;
  bool isLandlord;
  String phone;
  String gender;
  String address;
  String imageMem;

  UserDetailsResponse({
    required this.pk,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isLandlord,
    required this.phone,
    required this.gender,
    required this.address,
    required this.imageMem,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      UserDetailsResponse(
          pk: json["pk"],
          username: json["username"],
          email: json["email"],
          firstName: json["first_name"],
          lastName: json["last_name"],
          isLandlord: json["is_landlord"],
          phone: json['phone'],
          gender: json['gender'],
          address: json['address'],
          imageMem: json['imageMem']);

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "is_landlord": isLandlord,
        "phone": phone,
        "gender": gender,
        "address": address,
        "imageMem": imageMem
      };
}
