// To parse this JSON data, do
//
//     final servicesData = servicesDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServicesData servicesDataFromJson(String str) => ServicesData.fromJson(json.decode(str));

String servicesDataToJson(ServicesData data) => json.encode(data.toJson());

class ServicesData {
  ServicesData({
    required this.code,
    required this.msg,
    required this.bigData,
  });

  int code;
  String msg;
  BigData bigData;

  factory ServicesData.fromJson(Map<String, dynamic> json) => ServicesData(
    code: json["code"] == null ? null : json["code"],
    msg: json["msg"] == null ? null : json["msg"],
    bigData: json["bigData"] ?? null,// BigData.fromJson(json["bigData"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "msg": msg == null ? null : msg,
    "bigData": bigData == null ? null : bigData.toJson(),
  };
}

class BigData {
  BigData({
    required this.services,
  });

  Services services;

  factory BigData.fromJson(Map<String, dynamic> json) => BigData(
    services: json["services"],// == null ? null : Services.fromJson(json["services"]),
  );

  Map<String, dynamic> toJson() => {
    "services": services == null ? null : services.toJson(),
  };
}

class Services {
  Services({
    required this.posts,
  });

  List<Post> posts;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    posts: json["posts"],// == null ? null : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toJson())),
  };
}

class Post {
  Post({
    required this.id,
    required this.parent1,
    required this.parent2,
    required this.parent3,
    required this.parent4,
    required this.parent5,
    required this.postTypeId,
    required this.publish,
    required this.search,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.sku,
    required this.slug,
    required this.price,
    required this.regularPrice,
    required this.likes,
    required this.description,
    required this.availability,
    required this.companyId,
    required this.metaTitle,
    required this.metaDescription,
    required this.position,
    required this.local,
    required this.locale,
    required this.languageParent,
    required this.color,
    required this.stringDescription,
    required this.wishlist,
    required this.media,
    required this.reviews,
    required this.jsonData,
  });

  int id;
  dynamic parent1;
  dynamic parent2;
  dynamic parent3;
  dynamic parent4;
  dynamic parent5;
  int postTypeId;
  int publish;
  String search;
  String title;
  String subTitle;
  String image;
  String sku;
  String slug;
  dynamic price;
  dynamic regularPrice;
  dynamic likes;
  Description description;
  dynamic availability;
  int companyId;
  String metaTitle;
  String metaDescription;
  dynamic position;
  String local;
  String locale;
  int languageParent;
  String color;
  String stringDescription;
  int wishlist;
  List<dynamic> media;
  List<dynamic> reviews;
  List<JsonDatum> jsonData;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"] == null ? null : json["id"],
    parent1: json["parent_1"],
    parent2: json["parent_2"],
    parent3: json["parent_3"],
    parent4: json["parent_4"],
    parent5: json["parent_5"],
    postTypeId: json["post_type_id"] == null ? null : json["post_type_id"],
    publish: json["publish"] == null ? null : json["publish"],
    search: json["search"] == null ? null : json["search"],
    title: json["title"] == null ? null : json["title"],
    subTitle: json["sub_title"] == null ? null : json["sub_title"],
    image: json["image"] == null ? null : json["image"],
    sku: json["sku"] == null ? null : json["sku"],
    slug: json["slug"] == null ? null : json["slug"],
    price: json["price"],
    regularPrice: json["regular_price"],
    likes: json["likes"],
    description: json["description"],// == null ? null : Description.fromJson(json["description"]),
    availability: json["availability"],
    companyId: json["company_id"] == null ? null : json["company_id"],
    metaTitle: json["meta_title"] == null ? null : json["meta_title"],
    metaDescription: json["meta_description"] == null ? null : json["meta_description"],
    position: json["position"],
    local: json["local"] == null ? null : json["local"],
    locale: json["locale"] == null ? null : json["locale"],
    languageParent: json["language_parent"] == null ? null : json["language_parent"],
    color: json["color"] == null ? null : json["color"],
    stringDescription: json["string_description"] == null ? null : json["string_description"],
    wishlist: json["wishlist"] == null ? null : json["wishlist"],
    media: json["media"],// == null ? null : List<dynamic>.from(json["media"].map((x) => x)),
    reviews: json["reviews"],// == null ? null : List<dynamic>.from(json["reviews"].map((x) => x)),
    jsonData: json["json_data"],// == null ? null : List<JsonDatum>.from(json["json_data"].map((x) => JsonDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "parent_1": parent1,
    "parent_2": parent2,
    "parent_3": parent3,
    "parent_4": parent4,
    "parent_5": parent5,
    "post_type_id": postTypeId == null ? null : postTypeId,
    "publish": publish == null ? null : publish,
    "search": search == null ? null : search,
    "title": title == null ? null : title,
    "sub_title": subTitle == null ? null : subTitle,
    "image": image == null ? null : image,
    "sku": sku == null ? null : sku,
    "slug": slug == null ? null : slug,
    "price": price,
    "regular_price": regularPrice,
    "likes": likes,
    "description": description == null ? null : description.toJson(),
    "availability": availability,
    "company_id": companyId == null ? null : companyId,
    "meta_title": metaTitle == null ? null : metaTitle,
    "meta_description": metaDescription == null ? null : metaDescription,
    "position": position,
    "local": local == null ? null : local,
    "locale": locale == null ? null : locale,
    "language_parent": languageParent == null ? null : languageParent,
    "color": color == null ? null : color,
    "string_description": stringDescription == null ? null : stringDescription,
    "wishlist": wishlist == null ? null : wishlist,
    "media": media == null ? null : List<dynamic>.from(media.map((x) => x)),
    "reviews": reviews == null ? null : List<dynamic>.from(reviews.map((x) => x)),
    "json_data": jsonData == null ? null : List<dynamic>.from(jsonData.map((x) => x.toJson())),
  };
}

class Description {
  Description({
    required this.type,
    required this.data,
  });

  String type;
  List<int> data;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    type: json["type"] == null ? null : json["type"],
    data: json["data"],// == null ? null : List<int>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
  };
}

class JsonDatum {
  JsonDatum({
    required this.data,
    required this.id,
    required this.position,
  });

  String data;
  int id;
  dynamic position;

  factory JsonDatum.fromJson(Map<String, dynamic> json) => JsonDatum(
    data: json["data"] == null ? null : json["data"],
    id: json["id"] == null ? null : json["id"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data,
    "id": id == null ? null : id,
    "position": position,
  };
}
