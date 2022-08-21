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
    required this.best_sellers,
    required this.newArrivals,
    required this.recomended,
    required this.searchSuggestion,
    required this.offers,
  });

  PostList banners;
  PostList services;
  PostList brand;
  PostList gallary;
  PostList aboutHomePage;
  PostList aboutPage;
  PostList super_category;
  PostList reviews;
  PostList events;
  PostList blogs;
  PostList best_sellers;
  PostList offers;
  PostList newArrivals;
  PostList recomended;
  List<SearchSuggestion>? searchSuggestion;

  factory StartUp.fromJson(String str) => StartUp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartUp.fromMap(Map<String, dynamic> json) => StartUp(
    searchSuggestion: json["search_suggestion"] == null ? null : List<SearchSuggestion>.from(json["search_suggestion"].map((x) => SearchSuggestion.fromMap(x))),
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
    offers: PostList.fromMap(json["offers"]),
    best_sellers: PostList.fromMap(json["best_sellers"]),
    newArrivals: PostList.fromMap(json["new_arrivals"]),
    recomended: PostList.fromMap(json["recomended"]),
  );

  Map<String, dynamic> toMap() => {
    "search_suggestion": searchSuggestion == null ? null : List<dynamic>.from(searchSuggestion!.map((x) => x.toJson())),
    "banners": banners.toMap(),
    "services": services.toMap(),
    "brand": brand.toMap(),
    "gallary": gallary.toMap(),
    "aboutHomePage": aboutHomePage.toMap(),
    "aboutPage": aboutPage.toMap(),
    "reviews": reviews.toMap(),
    "blogs": blogs.toMap(),
    "events": events.toMap(),
    "best_sellers": best_sellers.toMap(),
    "offers": offers.toMap(),
    "new_arrivals": newArrivals.toJson(),
    "recomended": recomended.toJson(),
  };
}

class SearchSuggestion {
  SearchSuggestion({
    required this.title,
  });

  String title;

  factory SearchSuggestion.fromJson(String str) => SearchSuggestion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchSuggestion.fromMap(Map<String, dynamic> json) => SearchSuggestion(
    title: json["title"] == null ? "" : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "title": title == null ? null : title,
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


