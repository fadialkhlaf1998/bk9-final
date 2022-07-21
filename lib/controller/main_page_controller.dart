

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController{

  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  List<String> iconList = ['home', 'shop','services','cart','profile'];

  changeIndexOfBottomBar(index){
    selectedIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn);
  }

}