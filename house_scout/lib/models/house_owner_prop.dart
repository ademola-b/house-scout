import 'dart:convert';

import 'package:flutter/foundation.dart';

List<HouseOwnerProperty> houseOwnerPropertyFromJson(String str) =>
    List<HouseOwnerProperty>.from(
        json.decode(str).map((x) => HouseOwnerProperty.fromJson(x)));

String houseOwnerPropertyToJson(List<HouseOwnerProperty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseOwnerProperty {
  String? houseId;
  List<dynamic>? houseVisuals;
  User? user;
  String? name;
  String? desc;
  String? amount;
  String? address;
  String? longitude;
  String? latitude;
  String? radius;
  String? status;

  HouseOwnerProperty({
    this.houseId,
    this.houseVisuals,
    this.user,
    this.name,
    this.desc,
    this.amount,
    this.address,
    this.longitude,
    this.latitude,
    this.radius,
    this.status,
  });

  factory HouseOwnerProperty.fromJson(Map<String, dynamic> json) =>
      HouseOwnerProperty(
        houseId: json["house_id"],
        houseVisuals: json["house_visuals"] == null
            ? []
            : List<HouseVisual>.from(
                json["house_visuals"]!.map((x) => HouseVisual.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        name: json["name"],
        desc: json["desc"],
        amount: json["amount"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        radius: json["radius"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "house_id": houseId,
        "house_visuals": houseVisuals == null
            ? []
            : List<dynamic>.from(houseVisuals!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "name": name,
        "desc": desc,
        "amount": amount,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
        "status": status,
      };
}

class HouseVisual {
  String? visualId;
  Uint8List imageMem;

  HouseVisual({
    this.visualId,
    required this.imageMem,
  });

  factory HouseVisual.fromJson(Map<String, dynamic> json) => HouseVisual(
        visualId: json["visual_id"],
        imageMem: base64Decode(json["image_mem"]),
      );

  Map<String, dynamic> toJson() => {
        "visual_id": visualId,
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

  User({
    this.pk,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.isLandlord,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isLandlord: json["is_landlord"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "is_landlord": isLandlord,
      };
}
