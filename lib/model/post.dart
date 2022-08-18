import 'package:bk9/const/app-style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class PostDecoder {
  PostDecoder({
    required this.posts,
  });

  List<Post> posts;

  factory PostDecoder.fromJson(String str) => PostDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostDecoder.fromMap(Map<String, dynamic> json) => PostDecoder(
    posts: List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toMap())),
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
    required this.availability,
    required this.companyId,
    required this.metaTitle,
    required this.metaDescription,
    required this.position,
    required this.locale,
    required this.languageParent,
    required this.rate,
    required this.stringDescription,
    required this.wishlist,
    required this.media,
    required this.review,
    required this.jsonData,
    required this.count,
    required this.favorite,
    required this.my_rate,
    required this.cartCount,
    required this.posts,
    required this.color,
  });

  int id;
  int? parent1;
  int? parent2;
  int? parent3;
  int? parent4;
  int? parent5;
  int postTypeId;
  int? publish;
  String? search;
  String? title;
  String? subTitle;
  String? image;
  String? sku;
  String? slug;
  double price;
  double? regularPrice;
  Color color;
  dynamic likes;
  // Description description;
  int? availability;
  int companyId;
  String? metaTitle;
  String? metaDescription;
  int? position;
  String? locale;
  int? languageParent;
  double rate;
  double? my_rate;
  String? stringDescription;
  int? wishlist;
  List<Media>? media;
  List<Review>? review;
  List<JsonDatum>? jsonData;
  int? count;
  Rx<int> cartCount;
  Rx<bool> favorite;
  // Rx<bool> open=false.obs;
  List<Post>? posts;

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    id: json["id"] == null ? -1 : json["id"],
    parent1: json["parent_1"],
    parent2: json["parent_2"],
    parent3: json["parent_3"],
    parent4: json["parent_4"],
    parent5: json["parent_5"],
    postTypeId: json["post_type_id"],
    publish: json["publish"],
    search: json["search"],
    title: json["title"],
    subTitle: json["sub_title"],
    image: json["image"] == null ? "" : json["image"],
    sku: json["sku"],
    slug: json["slug"],
    price: json["price"]==null?-1:double.parse(json["price"].toString()),
    regularPrice: json["regular_price"]==null?null:double.parse(json["regular_price"].toString()),
    likes: json["likes"],
    color: AppStyle.hexToColor(json["color"]),
    availability: json["availability"] == null ? null : json["availability"],
    companyId: json["company_id"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    position: json["position"],
    locale: json["locale"],
    languageParent: json["language_parent"],
    rate: json["rate"]==null?0.0:double.parse(json["rate"].toString()),
    my_rate: json["my_rate"]==null?0.0:double.parse(json["my_rate"].toString()),
    stringDescription: json["string_description"],
    wishlist: json["wishlist"],
    media: json["media"]==null?null:List<Media>.from(json["media"].map((x) => Media.fromMap(x))),
    review: json["review"]==null?null:List<Review>.from(json["review"].map((x) => Review.fromMap(x))),
    jsonData: json["json_data"]==null?null:List<JsonDatum>.from(json["json_data"].map((x) => JsonDatum.fromMap(x))),
    count: json["count"],
    favorite:json["wishlist"]==null ? false.obs: json["wishlist"] ==0 ?false.obs:true.obs,
    posts:json["posts"]==null?null: List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
    cartCount:1.obs
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "parent_1": parent1,
    "parent_2": parent2,
    "parent_3": parent3,
    "parent_4": parent4,
    "parent_5": parent5,
    "post_type_id": postTypeId,
    "publish": publish,
    "search": search,
    "title": title,
    "sub_title": subTitle,
    "image": image,
    "sku": sku,
    "slug": slug,
    "price": price,
    "regular_price": regularPrice,
    "likes": likes,
    "availability": availability,
    "company_id": companyId,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "position": position,
    "locale": locale,
    "language_parent": languageParent,
    "rate": rate,
    "string_description": stringDescription,
    "wishlist": wishlist,
    "media":media==null?null: List<dynamic>.from(media!.map((x) => x.toMap())),
    "review": review==null?null:List<dynamic>.from(review!.map((x) => x.toMap())),
    "json_data":jsonData==null?null: List<dynamic>.from(jsonData!.map((x) => x.toMap())),
    "count": count,
    "my_rate": my_rate,
  };
}

class Description {
  Description({
    required this.type,
    required this.data,
  });

  String type;
  List<dynamic> data;

  factory Description.fromJson(String str) => Description.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Description.fromMap(Map<String, dynamic> json) => Description(
    type: json["type"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "data": List<dynamic>.from(data.map((x) => x)),
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
  int? position;

  factory JsonDatum.fromJson(String str) => JsonDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JsonDatum.fromMap(Map<String, dynamic> json) => JsonDatum(
    data: json["data"],
    id: json["id"],
    position: json["position"],
  );

  Map<String, dynamic> toMap() => {
    "data": data,
    "id": id,
    "position": position,
  };
}

class Media {
  Media({
    required this.link,
  });

  String link;

  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    link: json["link"],
  );

  Map<String, dynamic> toMap() => {
    "link": link,
  };
}

class Review {
  Review({
    required this.id,
    required this.postId,
    required this.customerId,
    required this.body,
    required this.rate,
    required this.firstname,
    required this.lastname,
  });

  int id;
  int postId;
  int customerId;
  String body;
  int rate;
  String firstname;
  String lastname;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["id"],
    postId: json["post_id"],
    customerId: json["customer_id"],
    body: json["body"],
    rate: json["rate"] == null ? 0 : json["rate"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "post_id": postId,
    "customer_id": customerId,
    "body": body,
    "rate": rate == null ? null : rate,
    "firstname": firstname,
    "lastname": lastname,
  };
}
