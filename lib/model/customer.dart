// To parse this JSON data, do
//
//     final customer = customerFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Customer {
  Customer({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.isActive,
    required this.code,
    required this.image,
    required this.companyId,
    required this.checkUnique,
  });

  int id;
  String firstname;
  String lastname;
  String email;
  String password;
  int isActive;
  String code;
  String image;
  int companyId;
  String checkUnique;

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"],
    isActive: json["is_active"],
    code: json["code"],
    image: json["image"]==null?"":json["image"],
    companyId: json["company_id"],
    checkUnique: json["check_unique"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password,
    "is_active": isActive,
    "code": code,
    "image": image,
    "company_id": companyId,
    "check_unique": checkUnique,
  };
}
