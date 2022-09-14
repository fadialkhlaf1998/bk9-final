import 'dart:convert';

import 'package:get/get.dart';

class CartItems {
  List<CartItem>? cart;

  CartItems({ this.cart});

  factory CartItems.fromJson(String str) => CartItems.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartItems.fromMap(Map<String, dynamic> json) => CartItems(
        cart: List<CartItem>.from(json["cart"].map((x) => CartItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cart": List<dynamic>.from(cart!.map((x) => x.toMap())),
      };
}

class CartItem {

  int cartId;
  int id;
  int customerId;
  int productOptionsId;
  int count;
  int weightId;
  int sizeId;
  int colorId;
  int productId;
  double additionalPrice;
  int stouck;
  String title;
  double price;
  String image;
  String size;
  String weight;
  String color;
  String degree;
  Rx<bool> loading_op=false.obs;


  CartItem({
     required this.cartId,
     required this.id,
     required this.customerId,
     required this.productOptionsId,
     required this.count,
     required this.weightId,
     required this.sizeId,
     required this.colorId,
     required this.productId,
     required this.additionalPrice,
     required this.stouck,
     required this.title,
     required this.price,
     required this.image,
     required this.size,
     required this.weight,
     required this.color,
     required this.degree,
  });

  factory CartItem.fromJson(String str) => CartItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
    cartId: json["cart_id"] == null ? -1 : json["cart_id"],
    id: json["id"] == null ? -1 : json["id"],
    customerId: json["customer_id"] == null ? -1 : json["customer_id"],
    productOptionsId:  json["product_options_id"],
    count: json["count"] == null ? -1 : json["count"],
    weightId: json["weight_id"] == null ? -1 : json["weight_id"],
    sizeId: json["size_id"] == null ? -1 : json["size_id"],
    colorId: json["color_id"] == null ? -1 : json["color_id"],
    productId: json["product_id"] == null ? -1 : json["product_id"],
    additionalPrice: json["additional_price"] == null ? -1 : double.parse(json["additional_price"]),
    stouck: json["stouck"] == null ? -1 : json["stouck"],
    title: json["title"] == null ? "" : json["title"],
    price: json["price"] == null ? -1 : double.parse(json["price"]),
    image: json["image"] == null ? "" : json["image"],
    size: json["size"] == null ? "" : json["size"],
    weight: json["weight"] == null ? "" : json["weight"],
    color: json["color"] == null ? "" : json["color"],
    degree: json["degree"] == null ? "" : json["degree"],
  );

  Map<String, dynamic> toMap() => {
    "cart_id": cartId == null ? null : cartId,
    "id": id == null ? null : id,
    "customer_id": customerId == null ? null : customerId,
    "product_options_id": productOptionsId == null ? null : productOptionsId,
    "count": count == null ? null : count,
    "weight_id": weightId == null ? null : weightId,
    "size_id": sizeId == null ? null : sizeId,
    "color_id": colorId == null ? null : colorId,
    "product_id": productId == null ? null : productId,
    "additional_price": additionalPrice == null ? null : additionalPrice,
    "stouck": stouck == null ? null : stouck,
    "title": title == null ? null : title,
    "price": price == null ? null : price,
    "image": image == null ? null : image,
    "size": size == null ? null : size,
    "weight": weight == null ? null : weight,
    "color": color == null ? null : color,
    "degree": degree == null ? null : degree,
  };
}
