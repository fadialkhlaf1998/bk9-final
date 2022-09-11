import 'package:bk9/const/store.dart';
import 'package:bk9/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class IntroScreenController extends GetxController {

  ItemScrollController itemScrollController = ItemScrollController();
  var nextValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  RxList screens = [
    {"image":"assets/icons/book_boarding.svg","title":"Book a Boarding","description":"Professional Dog and Cat Boarding.  Available for Day Care, Daily, Weekly andMonthly boarding."},
    {"image":"assets/icons/shop2.svg","title":"Shop","description":"Check out our latest deals for your fur babies!"},
    {"image":"assets/icons/grooming.svg","title":"Grooming","description":"Book an in-store grooming session for your dog and cat."},
  ].obs;

  Future next(index, lastIndex) async{
    itemScrollController.scrollTo(
        index: index,
        alignment: -0.03, //index == 0 ? 0.5 : index == lastIndex - 1 ? 0.5 : 0.5,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1000)
    );
  }
  Future back(index, lastIndex) async{
    itemScrollController.scrollTo(
        index: index,
        alignment: 0.03, //index == 0 ? 0.5 : index == lastIndex - 1 ? 0.5 : 0.5,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1000)
    );
  }

  goToNextPage(){
    if(nextValue.value < screens.length) {
      if(nextValue.value == 2){
        Store.saveIntroScreen(true);
        Get.offAll(()=>MainPage());
      }else{
        nextValue.value++;
        next(nextValue.value, screens.length);
        print(nextValue.value);
      }
    }
  }

  goToPreviousPage(){
    if(nextValue.value >= 1) {
      nextValue.value--;
      back(nextValue.value, screens.length);
      print(nextValue.value);
    }
  }



}