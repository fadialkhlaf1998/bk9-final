import 'dart:convert';

class Brands {
  Brands({
    required this.code,
    required this.msg,
    required this.brand,
  });

  int code;
  String msg;
  Brand? brand;

  factory Brands.fromJson(String str) => Brands.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brands.fromMap(Map<String, dynamic> json) => Brands(
    code: json["code"] == null ? -1 : json["code"],
    msg: json["msg"] == null ? "" : json["msg"],
    brand: json["brand"] == null ? null : Brand.fromMap(json["brand"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "msg": msg == null ? null : msg,
    "brand": brand == null ? null : brand!.toJson(),
  };
}

class Brand{
  Brand({
    required this.brandInfo,
  });

  List<BrandInfo>? brandInfo;

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
    brandInfo: json["brand_info"] == null ? null : List<BrandInfo>.from(json["brand_info"].map((x) => BrandInfo.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "brand_info": brandInfo == null ? null : List<dynamic>.from(brandInfo!.map((x) => x.toJson())),
  };
}

class BrandInfo {
  BrandInfo({
    required this.id,
    required this.postTypeId,
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
    required this.color,
    required this.languageParent,
    required this.stringDescription,
    required this.wishlist,
  });

  int id;
  int postTypeId;
  String title;
  String subTitle;
  String image;
  String sku;
  String slug;
  int price;
  int regularPrice;
  dynamic likes;
  int availability;
  int companyId;
  String metaTitle;
  String metaDescription;
  dynamic position;
  String color;
  int languageParent;
  String stringDescription;
  int wishlist;

  factory BrandInfo.fromJson(String str) => BrandInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory BrandInfo.fromMap(Map<String, dynamic> json) => BrandInfo(
    id: json["id"] == null ? -1 : json["id"],
    postTypeId: json["post_type_id"] == null ? -1 : json["post_type_id"],
    title: json["title"] == null ? "" : json["title"],
    subTitle: json["sub_title"] == null ? "" : json["sub_title"],
    image: json["image"] == null ? "" : json["image"],
    sku: json["sku"] == null ? "" : json["sku"],
    slug: json["slug"] == null ? "" : json["slug"],
    price: json["price"] == null ? -1 : json["price"],
    regularPrice: json["regular_price"] == null ? -1 : json["regular_price"],
    likes: json["likes"],
    availability: json["availability"] == null ? -1 : json["availability"],
    companyId: json["company_id"] == null ? -1 : json["company_id"],
    metaTitle: json["meta_title"] == null ? "" : json["meta_title"],
    metaDescription: json["meta_description"] == null ? "" : json["meta_description"],
    position: json["position"],
    color: json["color"] == null ? "" : json["color"],
    languageParent: json["language_parent"] == null ? -1 : json["language_parent"],
    stringDescription: json["string_description"] == null ? "" : json["string_description"],
    wishlist: json["wishlist"] == null ? -1 : json["wishlist"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "post_type_id": postTypeId == null ? null : postTypeId,
    "title": title == null ? null : title,
    "sub_title": subTitle == null ? null : subTitle,
    "image": image == null ? null : image,
    "sku": sku == null ? null : sku,
    "slug": slug == null ? null : slug,
    "price": price == null ? null : price,
    "regular_price": regularPrice == null ? null : regularPrice,
    "likes": likes,
    "availability": availability == null ? null : availability,
    "company_id": companyId == null ? null : companyId,
    "meta_title": metaTitle == null ? null : metaTitle,
    "meta_description": metaDescription == null ? null : metaDescription,
    "position": position,
    "color": color == null ? null : color,
    "language_parent": languageParent == null ? null : languageParent,
    "string_description": stringDescription == null ? null : stringDescription,
    "wishlist": wishlist == null ? null : wishlist,
  };
}
