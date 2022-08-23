import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/view/product_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSelectionController extends GetxController{
  var loading = false.obs;
  var categoryOpen = false.obs;
  var brandOpen = false.obs;
  var selected_brand_id = (-1).obs;
  var selected_super_category = (-1).obs;
  var selected_category = (-1).obs;
  var selected_sub_category = (-1).obs;
  // var open_super_category = (-1).obs;
  // var open_category = (-1).obs;

  clear(){
    categoryOpen.value=false;
    brandOpen.value=false;
    selected_brand_id = (-1).obs;
    selected_super_category = (-1).obs;
    selected_category = (-1).obs;
    selected_sub_category = (-1).obs;
  }

  apply(BuildContext context){
    loading.value = true;
    API.filter(selected_sub_category.value, selected_category.value, selected_super_category.value, selected_brand_id.value).then((value) {
      loading.value = false;
      if(value.isNotEmpty){
        Get.off(() => ProductFilter(value,"Filter"));
      }else{
        AppStyle.errorMsg(context, "This filter has no elements");
      }

    }).catchError((err){
      loading.value = false;
    });
  }

}