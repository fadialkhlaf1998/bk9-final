import 'dart:convert';

class LogInInfo {
  LogInInfo({
    required this.email,
    required this.password,
    required this.id
  });

  String email;
  String password;
  String id;

  factory LogInInfo.fromJson(String str) => LogInInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LogInInfo.fromMap(Map<String, dynamic> json) => LogInInfo(
    email: json["email"],
    password: json["password"],
    id: json["customer_id"]
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "password": password,
    "customer_id": id
  };
}