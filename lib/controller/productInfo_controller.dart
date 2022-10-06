import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/model/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductInfoController extends GetxController {

  TextEditingController review = TextEditingController();
  CarouselController carouselController = CarouselController();
  var counter = 1.obs;
  var lastRate = 0.obs;
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
    sizeValue.value="";
    colorValue.value="";
    weightValue.value="";
    activeIndex.value=0;
    selectedColorIndex.value=0;
    selectedDesFea.value=0;
    counter.value=1;
    lastRate = product!.myRate.obs;
    if(product!.colors!=null&&product!.colors!.isNotEmpty){
      selectedColorId.value = product!.colors![0].colorId;
      selectedColorIndex.value = getIndexColorImages(selectedColorId.value,product!.colorsImages!);
    }else{
      selectedColorId.value = 0;
    }
    if(product!.weights!=null&&product!.weights!.isNotEmpty){
      selectedWeightId.value = product!.weights![0].weightId;
    }else{
      selectedWeightId.value = 0;
    }
    if(product!.sizes!=null&&product!.sizes!.isNotEmpty){
      selectedSizeId.value = product!.sizes![0].sizeId;
    }else{
      selectedSizeId.value = 0;
    }

  }

  onSelectOption() {
    print('size:' +selectedSizeId.toString());
    print('color:' +selectedColorId.toString());
    print('weight:' +selectedWeightId.toString());

    for(int i=0;i<product!.options!.length;i++){
        int? tempSize = selectedSizeId==0?null:selectedSizeId.value;
        int? tempColor = selectedColorId==0?null:selectedColorId.value;
        int? tempWeight = selectedWeightId==0?null:selectedWeightId.value;
        print('------------');
      if(product!.options![i].colorId == tempColor && product!.options![i].sizeId == tempSize && product!.options![i].weightId == tempWeight){
          selectedOption.value = i;
          return i;
        }
    }
    selectedOption.value = -1;
    return 0;
  }

  /// cart
  increase() {
    counter.value++;
  }
  decrease() {
    counter.value--;
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
  getColorId(String title, List<MyColor> colors){
    for(int i=0;i<colors.length;i++){
      if(colors[i].title == title){
        return colors[i].colorId;
      }
    }
    return 0;
  }
  getWeightId(String title, List<Weight> list){
    for(int i=0;i<list.length;i++){
      if(list[i].title == title){
        return list[i].weightId;
      }
    }
    return 0;
  }
  getSizeId(String title, List<Size> list){
    for(int i=0;i<list.length;i++){
      if(list[i].title == title){
        return list[i].sizeId;
      }
    }
    return 0;
  }

  /// rate
  rateProduct(int rate){
    // print('rated for id ${product!.id}');
    API.addRate(product!.id, rate);
  }

  /// review
  reviewProduct(BuildContext context){
    if(review.text.isNotEmpty){
      API.addReview(product!.id, review.text);
      product!.review!.insert(0,Review(body: review.text,customerId: API.customer_id,firstname: API.customer!.firstname,id: -1,lastname: "",postId: product!.id,rate: lastRate.value));
      loading.value=true;
      loading.value=false;
      review.clear();
    }else{
      // AppStyle.errorMsg(context,"Please");
    }

  }
}