import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/model/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductInfoController extends GetxController {

  ScrollController scrollController = ScrollController();
  CarouselController carouselController = CarouselController();
  var counter = 1.obs;
  CartController cartController = Get.find();
  var sizeValue = "".obs;
  var colorValue = "".obs;
  var weightValue = "".obs;
  var activeIndex = 0.obs;
  var selectedColorIndex = 0.obs;
  var selectedDesFea = 0.obs;
  Product? product;
  var selectedSizeId = 0.obs;
  var selectedColorId = 0.obs;
  var selectedWeightId = 0.obs;
  var selectedOption = 0.obs;
  Rx<bool> loading = false.obs;

  onStartInit(){
    if(product!.colors!=null&&product!.colors!.isNotEmpty){
      selectedColorId.value = product!.colors![0].colorId;
      selectedColorIndex.value = getIndexColorImages(selectedColorId.value,product!.colorsImages!);
    }
    if(product!.weights!=null&&product!.weights!.isNotEmpty){
      selectedWeightId.value = product!.weights![0].weightId;
    }
    if(product!.sizes!=null&&product!.sizes!.isNotEmpty){
      selectedSizeId.value = product!.sizes![0].sizeId;
    }
  }
  onSelectOption() {
      for(int i=0;i<product!.options!.length;i++){
        var tempSize = selectedSizeId==0?null:selectedSizeId;
        var tempColor = selectedColorId==0?null:selectedColorId;
        var tempWeight = selectedWeightId==0?null:selectedWeightId;
        if(product!.options![i].colorId == tempColor && product!.options![i].sizeId == tempSize && product!.options![i].weightId == tempWeight){
          selectedOption.value = i;
          return i;
        }
        selectedOption.value = 0;
        return 0;
      }
  }

  /// cart
  increase() {
    counter++;
  }
  decrease() {
    counter--;
  }

  /// for product images
  setIndex(int selected) {
    activeIndex.value = selected;
  }
  getIndex(String title, List<MyColor> colors){
     for(int i=0;i<colors.length;i++){
       if(colors[i].title == title){
         return i;
       }
     }
     return -1;
  }
  getIndexColorImages(int colorId, List<ColorsImage> colors){
    for(int i=0;i<colors.length;i++){
      if(colors[i].colorId == colorId){
        return i;
      }
    }
    return 0;
  }

}