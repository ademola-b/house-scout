// To parse this JSON data, do
//
//     final registrationResponse = registrationResponseFromJson(jsonString);

import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  List<String>? username;
  List<String>? email;
  List<String>? password1;
  List<String>? password2;

  RegistrationResponse({
    this.username,
    this.email,
    this.password1,
    this.password2,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        username: List<String>.from(json["username"].map((x) => x)),
        email: List<String>.from(json["email"].map((x) => x)),
        password1: List<String>.from(json["password1"].map((x) => x)),
        password2: List<String>.from(json["password2"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": List<dynamic>.from(username!.map((x) => x)),
        "email": List<dynamic>.from(email!.map((x) => x)),
        "password1": List<dynamic>.from(password1!.map((x) => x)),
        "password2": List<dynamic>.from(password2!.map((x) => x)),
      };
}
