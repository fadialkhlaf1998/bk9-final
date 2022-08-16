import 'dart:convert';

import 'package:bk9/model/post.dart';

class CustomSearch {
  CustomSearch({
    required this.services,
    required this.products,
  });

  PostList services;
  PostList products;

  factory CustomSearch.fromJson(String str) => CustomSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomSearch.fromMap(Map<String, dynamic> json) => CustomSearch(
    services: PostList.fromMap(json["services"]),
    products: PostList.fromMap(json["products"]),
  );

  Map<String, dynamic> toMap() => {
    "services": services.toMap(),
    "products": products.toMap(),
  };
}

class PostList {
  PostList({
    required this.posts,
  });

  List<Post> posts;

  factory PostList.fromJson(String str) => PostList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostList.fromMap(Map<String, dynamic> json) => PostList(
    posts: List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toMap())),
  };
}


