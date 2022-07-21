import 'dart:convert';

import 'package:bk9/model/post.dart';

class StartUp {
  StartUp({
    required this.banners,
    required this.services,
    required this.brand,
    required this.gallary,
    required this.aboutHomePage,
    required this.aboutPage,
    required this.super_category,
    required this.blogs,
    required this.events,
    required this.reviews,
  });

  PostList banners;
  //PostList categories;
  PostList services;
  //PostList products;
  PostList brand;
  PostList gallary;
  PostList aboutHomePage;
  PostList aboutPage;
  PostList super_category;
  PostList reviews;
  PostList events;
  PostList blogs;

  factory StartUp.fromJson(String str) => StartUp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartUp.fromMap(Map<String, dynamic> json) => StartUp(
    banners: PostList.fromMap(json["banners"]),
    services: PostList.fromMap(json["services"]),
    brand: PostList.fromMap(json["brand"]),
    gallary: PostList.fromMap(json["gallary"]),
    aboutHomePage: PostList.fromMap(json["aboutHomePage"]),
    aboutPage: PostList.fromMap(json["aboutPage"]),
    super_category: PostList.fromMap(json["super_categories"]),
    reviews: PostList.fromMap(json["reviews"]),
    blogs: PostList.fromMap(json["blogs"]),
    events: PostList.fromMap(json["events"]),
  );

  Map<String, dynamic> toMap() => {
    "banners": banners.toMap(),
    "services": services.toMap(),
    "brand": brand.toMap(),
    "gallary": gallary.toMap(),
    "aboutHomePage": aboutHomePage.toMap(),
    "aboutPage": aboutPage.toMap(),
    "reviews": reviews.toMap(),
    "blogs": blogs.toMap(),
    "events": events.toMap(),
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
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toMap() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
  };
}


