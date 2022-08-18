import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/view/product_filter.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  CarouselController carouselController = CarouselController();
  TextEditingController search = TextEditingController();
  var activeIndex = 0.obs;
  var selectedServices = 0.obs;


  /// remove later
  // List<Post> events = <Post>[];


  set_index(int selected){
    activeIndex.value=selected;
  }

}