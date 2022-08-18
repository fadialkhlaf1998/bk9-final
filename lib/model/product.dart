import 'dart:convert';

import 'package:bk9/model/post.dart';
import 'package:get/get.dart';

class Products {
  Products({
    required this.code,
    required this.msg,
    required this.product,
  });

  int code;
  String msg;
  List<Product>? product;

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
    code: json["code"] == null ? -1 : json["code"],
    msg: json["msg"] == null ? "null" : json["msg"],
    product: json["data"] == null ? null : List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "msg": msg == null ? null : msg,
    "product": product == null ? null : List<dynamic>.from(product!.map((x) => x.toJson())),
  };

}


class Product {
  Product({
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
    required this.myRate,
    required this.rate,
    required this.stringDescription,
    required this.wishlist,
    required this.media,
    required this.review,
    required this.jsonData,
    required this.options,
    required this.colorsImages,
    required this.colors,
    required this.sizes,
    required this.weights,
    required this.favorite,
  });

  int id;
  int postTypeId;
  String title;
  String subTitle;
  String image;
  String sku;
  String slug;
  int? price;
  int regularPrice;
  int likes;
  int availability;
  int companyId;
  String metaTitle;
  String metaDescription;
  dynamic position;
  String color;
  int languageParent;
  int myRate;
  double rate;
  String stringDescription;
  int wishlist;
  RxBool favorite;
  List<Media>? media;
  List<Review>? review;
  List<dynamic>? jsonData;
  List<Option>? options;
  List<ColorsImage>? colorsImages;
  List<MyColor>? colors;
  List<Size>? sizes;
  List<Weight>? weights;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) {
    print(json["my_rate"]);
    return Product(
      id: json["id"] == null ? -1 : json["id"],
      postTypeId: json["post_type_id"] == null ? -1 : json["post_type_id"],
      title: json["title"] == null ? "null" : json["title"],
      subTitle: json["sub_title"] == null ? "null" : json["sub_title"],
      image: json["image"] == null ? "" : json["image"],
      sku: json["sku"] == null ? "null" : json["sku"],
      slug: json["slug"] == null ? "null" : json["slug"],
      price: json["price"] == null ? -1 : json["price"],
      regularPrice: json["regular_price"] == null ? -1 : json["regular_price"],
      likes: json["likes"] == null ? -1 : json["likes"],
      availability: json["availability"] == null ? -1 : json["availability"],
      companyId: json["company_id"] == null ? -1 : json["company_id"],
      metaTitle: json["meta_title"] == null ? "null" : json["meta_title"],
      metaDescription: json["meta_description"] == null ? "null" : json["meta_description"],
      position: json["position"],
      color: json["color"] == null ? "null" : json["color"],
      languageParent: json["language_parent"] == null ? -1 : json["language_parent"],
      myRate: json["my_rate"] == null ?0:int.parse(json["my_rate"].toString()),
      rate: json["rate"] == null ?0.0:double.parse(json["rate"].toString()),
      stringDescription: json["string_description"] == null ? "null" : json["string_description"],
      wishlist: json["wishlist"] == null ? -1 : json["wishlist"],
      favorite: json["wishlist"] == null ? false.obs : json["wishlist"] == 0 ?false.obs:true.obs,
      media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromMap(x))),
      review: json["review"] == null ? <Review>[] : List<Review>.from(json["review"].map((x) => Review.fromMap(x))),
      jsonData: json["json_data"] == null ? null : List<dynamic>.from(json["json_data"].map((x) => x)),
      options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
      colorsImages: List<ColorsImage>.from(json["colorsImages"].map((x) => ColorsImage.fromMap(x))),
      colors: List<MyColor>.from(json["colors"].map((x) => MyColor.fromMap(x))),
      sizes: List<Size>.from(json["sizes"].map((x) => Size.fromMap(x))),
      weights: List<Weight>.from(json["weights"].map((x) => Weight.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "post_type_id": postTypeId == null ? null : postTypeId,
    "title": title == null ? null : title,
    "sub_title": subTitle == null ? null : subTitle,
    "image": image,
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
    "my_rate": myRate,
    "rate": rate,
    "string_description": stringDescription == null ? null : stringDescription,
    "wishlist": wishlist == null ? null : wishlist,
    "media": media == null ? null : List<dynamic>.from(media!.map((x) => x)),
    "review": review == null ? null : List<dynamic>.from(review!.map((x) => x)),
    "json_data": jsonData == null ? null : List<dynamic>.from(jsonData!.map((x) => x)),
    "options": options == null ? null : List<dynamic>.from(options!.map((x) => x.toJson())),
    "colorsImages": colorsImages == null ? null : List<dynamic>.from(colorsImages!.map((x) => x.toJson())),
    "colors": colors == null ? null : List<dynamic>.from(colors!.map((x) => x.toJson())),
    "sizes": sizes == null ? null : List<dynamic>.from(sizes!.map((x) => x.toJson())),
    "weights": weights == null ? null : List<dynamic>.from(weights!.map((x) => x.toJson())),
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
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toMap() => {
    "link": link == null ? null : link,
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
    rate: json["my_rate"]==null?0:json["my_rate"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "post_id": postId,
    "customer_id": customerId,
    "body": body,
    "rate": rate,
    "firstname": firstname,
    "lastname": lastname,
  };
}


class MyColor {
  MyColor({
    required this.colorId,
    required this.title,
    required this.degree,
  });

  int colorId;
  String title;
  String degree;

  factory MyColor.fromJson(String str) => MyColor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyColor.fromMap(Map<String, dynamic> json) => MyColor(
    colorId: json["color_id"] == null ? -1 : json["color_id"],
    title: json["title"] == null ? "null" : json["title"],
    degree: json["degree"] == null ? "null" : json["degree"],
  );

  Map<String, dynamic> toMap() => {
    "color_id": colorId == null ? null : colorId,
    "title": title == null ? null : title,
    "degree": degree == null ? null : degree,
  };
}

class ColorsImage {
  ColorsImage({
    required this.id,
    required this.colorId,
    required this.productId,
    required this.images,
  });

  int id;
  int colorId;
  int productId;
  List<Image>? images;

  factory ColorsImage.fromJson(String str) => ColorsImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory ColorsImage.fromMap(Map<String, dynamic> json) => ColorsImage(
    id: json["id"] == null ? -1 : json["id"],
    colorId: json["color_id"] == null ? "null" : json["color_id"],
    productId: json["product_id"] == null ? "null" : json["product_id"],
    images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "color_id": colorId == null ? null : colorId,
    "product_id": productId == null ? null : productId,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    required this.link,
  });

  String link;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    link: json["link"] == null ? "null" : json["link"],
  );

  Map<String, dynamic> toMap() => {
    "link": link == null ? null : link,
  };
}

class Option {
  Option({
    required this.id,
    required this.weightId,
    required this.sizeId,
    required this.colorId,
    required this.productId,
    required this.additionalPrice,
    required this.stock,
    required this.weight,
    required this.size,
    required this.color,
    required this.degree,
  });

  int id;
  int weightId;
  int sizeId;
  int colorId;
  int productId;
  int additionalPrice;
  int stock;
  String weight;
  String size;
  String color;
  String degree;

  factory Option.fromJson(String str) => Option.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Option.fromMap(Map<String, dynamic> json) => Option(
    id: json["id"] == null ? -1 : json["id"],
    weightId: json["weight_id"] == null ? -1 : json["weight_id"],
    sizeId: json["size_id"] == null ? -1 : json["size_id"],
    colorId: json["color_id"] == null ? -1 : json["color_id"],
    productId: json["product_id"] == null ? -1 : json["product_id"],
    additionalPrice: json["additional_price"] == null ? -1 : json["additional_price"],
    stock: json["stouck"] == null ? -1 : json["stouck"],
    weight: json["weight"] == null ? "null" : json["weight"],
    size: json["size"] == null ? "null" : json["size"],
    color: json["color"] == null ? "null" : json["color"],
    degree: json["degree"] == null ? "null" : json["degree"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "weight_id": weightId == null ? null : weightId,
    "size_id": sizeId == null ? null : sizeId,
    "color_id": colorId == null ? null : colorId,
    "product_id": productId == null ? null : productId,
    "additional_price": additionalPrice == null ? null : additionalPrice,
    "stock": stock == null ? null : stock,
    "weight": weight == null ? null : weight,
    "size": size == null ? null : size,
    "color": color == null ? null : color,
    "degree": degree == null ? null : degree,
  };

}

class Size {
  Size({
    required this.sizeId,
    required this.title,
  });

  int sizeId;
  String title;

  factory Size.fromJson(String str) => Size.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Size.fromMap(Map<String, dynamic> json) => Size(
    sizeId: json["size_id"] == null ? -1 : json["size_id"],
    title: json["title"] == null ? "null" : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "size_id": sizeId == null ? null : sizeId,
    "title": title == null ? null : title,
  };
}

class Weight {
  Weight({
    required this.weightId,
    required this.title,
  });

  int weightId;
  String title;

  factory Weight.fromJson(String str) => Weight.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Weight.fromMap(Map<String, dynamic> json) => Weight(
    weightId: json["weight_id"] == null ? -1 : json["weight_id"],
    title: json["title"] == null ? "null" : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "weight_id": weightId == null ? null : weightId,
    "title": title == null ? null : title,
  };
}
