import 'package:bk9/const/api.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/model/start_up.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  CarouselController carouselController = CarouselController();
  TextEditingController search = TextEditingController();
  var activeIndex = 0.obs;
  List<Post> service = <Post>[];

  RxList<String> carouselSliderImages = [
    'assets/images/Background.png',
    'assets/images/Background.png',
    'assets/images/Background.png',
  ].obs;

  set_index(int selected){
    activeIndex.value=selected;
  }

  @override
  void onInit() {
    super.onInit();
    // get_data();
  }

  get_data() {
    print('-------------------------');
    API.getServices().then((value) async {
      print(value.length);
      print('+++++++++++++++++++++++++++');
      service.addAll(value);
      print(service.length);
    });
  }

}