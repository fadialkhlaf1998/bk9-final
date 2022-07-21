import 'package:get/get.dart';

class ShopController extends GetxController{

  Rx<int> selectedSuperCategory = 0.obs;
  Rx<int> selectedCategory = 0.obs;
  Rx<int> selectedSubCategory = 0.obs;

  RxBool loading = false.obs;

}