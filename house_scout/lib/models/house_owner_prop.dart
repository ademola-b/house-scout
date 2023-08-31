// To parse this JSON data, do
//
//     final houseOwnerProperty = houseOwnerPropertyFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<HouseOwnerProperty> houseOwnerPropertyFromJson(String str) =>
    List<HouseOwnerProperty>.from(
        json.decode(str).map((x) => HouseOwnerProperty.fromJson(x)));

String houseOwnerPropertyToJson(List<HouseOwnerProperty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseOwnerProperty {
  String? houseId;
  User? user;
  String? name;
  String? desc;
  String? amount;
  String? address;
  List<dynamic>? houseVisuals;
  String? longitude;
  String? latitude;
  String? radius;
  String? status;
  String? category;
  int? bedroom;
  int? bathroom;
  int? kitchen;
  String? furnishedType;
  String? tenantType;

  HouseOwnerProperty(
      {this.houseId,
      this.user,
      this.name,
      this.desc,
      this.amount,
      this.address,
      this.houseVisuals,
      this.longitude,
      this.latitude,
      this.radius,
      this.status,
      this.category,
      this.bedroom,
      this.bathroom,
      this.kitchen,
      this.furnishedType,
      this.tenantType});

  factory HouseOwnerProperty.fromJson(Map<String, dynamic> json) =>
      HouseOwnerProperty(
          houseId: json["house_id"],
          user: json["user"] == null ? null : User.fromJson(json["user"]),
          name: json["name"],
          desc: json["desc"],
          amount: json["amount"],
          address: json["address"],
          houseVisuals: json["house_visuals"] == null
              ? []
              : List<HouseVisual>.from(
                  json["house_visuals"]!.map((x) => HouseVisual.fromJson(x))),
          longitude: json["longitude"],
          latitude: json["latitude"],
          radius: json["radius"],
          status: json["status"],
          category: json["category"],
          bedroom: json["bedroom"],
          bathroom: json["bathroom"],
          kitchen: json["kitchen"],
          furnishedType: json["furnished_type"],
          tenantType: json["tenant_type"]);

  Map<String, dynamic> toJson() => {
        "house_id": houseId,
        "user": user?.toJson(),
        "name": name,
        "desc": desc,
        "amount": amount,
        "address": address,
        "house_visuals": houseVisuals == null
            ? []
            : List<dynamic>.from(houseVisuals!.map((x) => x.toJson())),
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
        "status": status,
        "category": category,
        "bedroom": bedroom,
        "bathroom": bathroom,
        "kitchen": kitchen,
        "furnished_type": furnishedType,
        "tenantType": tenantType
      };
}

class HouseVisual {
  String? visualId;
  int? index;
  Uint8List imageMem;

  HouseVisual({
    this.visualId,
    this.index,
    required this.imageMem,
  });

  factory HouseVisual.fromJson(Map<String, dynamic> json) => HouseVisual(
        visualId: json["visual_id"],
        index: json["index"],
        imageMem: base64Decode(json["image_mem"]),
      );

  Map<String, dynamic> toJson() => {
        "visual_id": visualId,
        "index": index,
        "image_mem": imageMem,
      };
}

class User {
  int? pk;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  bool? isLandlord;
  String? phone;
  String? gender;
  String? address;
  Uint8List? imageMem;

  User({
    this.pk,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.isLandlord,
    this.phone,
    this.gender,
    this.address,
    this.imageMem,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isLandlord: json["is_landlord"],
        phone: json['phone'],
        gender: json['gender'],
        address: json['address'],
        imageMem: base64Decode(json['imageMem']),
      );

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
