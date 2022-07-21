import 'dart:convert';


class Addresses {
  Addresses({
    required this.address,
  });

  List<Address>? address;

  factory Addresses.fromJson(String str) => Addresses.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Addresses.fromMap(Map<String, dynamic> json) => Addresses(
    address: json["address"] == null ? null : List<Address>.from(json["address"].map((x) => Address.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "address": address == null ? null : List<dynamic>.from(address!.map((x) => x.toJson())),
  };

}

class Address {
  Address({
    required this.id,
    required this.customerId,
    required this.isDefault,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address1,
    required this.address2,
    required this.apartment,
    required this.phone,
    required this.country,
    required this.state,
  });

  int id;
  int customerId;
  int isDefault;
  String firstName;
  String lastName;
  String email;
  String address1;
  String address2;
  String apartment;
  String phone;
  String country;
  String state;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["id"] == null ? -1 : json["id"],
    customerId: json["customer_id"] == null ? -1 : json["customer_id"],
    isDefault: json["is_default"] == null ? -1 : json["is_default"],
    firstName: json["first_name"] == null ? "" : json["first_name"],
    lastName: json["last_name"] == null ? "" : json["last_name"],
    email: json["email"] == null ? "" : json["email"],
    address1: json["address_1"] == null ? "" : json["address_1"],
    address2: json["address_2"] == null ? "" : json["address_2"],
    apartment: json["apartment"] == null ? "" : json["apartment"],
    phone: json["phone"] == null ? "" : json["phone"],
    country: json["country"] == null ? "" : json["country"],
    state: json["state"] == null ? "" : json["state"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "customer_id": customerId == null ? null : customerId,
    "is_default": isDefault,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "address_1": address1 == null ? null : address1,
    "address_2": address2 == null ? null : address2,
    "apartment": apartment == null ? null : apartment,
    "phone": phone == null ? null : phone,
    "country": country == null ? null : country,
    "state": state == null ? null : state,
  };
}
