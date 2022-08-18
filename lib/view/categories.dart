import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/view/sub_categories_products.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_filter_sort.dart';
import 'package:bk9/widgets/headers/three_items_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatelessWidget {

  List<Post> categories;
  Categories(this.categories);

  ShopController shopController = Get.find();
  IntroController introController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: AppStyle.getDeviceHeightPercent(13, context),),
                    SizedBox(height: 80),
                    _cartegoryList(context),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      color: AppStyle.primary,
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   child:  CustomFilterSort(shopController: shopController,off: false),
                    // ),
                    ThreeItemsHeader(
                        onTap: () {
                          Get.back();
                        },
                        introController: introController,
                        text: introController.superCategory[shopController.selectedSuperCategory.value].title!,
                        textStyle: CommonTextStyle.textStyleForGreyMediumButtonBold
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  _cartegoryList(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 6/3
        ),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: categories.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap:  (){
                shopController.selectedCategory.value = index;
                if(introController.superCategory[shopController.selectedSuperCategory.value].posts![index].posts!.isEmpty) {
                  AppStyle.errorMsg(context, "This category is empty");
                } else {
                  Get.to(() => SubCategoriesProducts(
                      introController.superCategory[shopController.selectedSuperCategory.value].posts![index].posts!));
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(1,3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(categories[index].image!),
                              fit: BoxFit.contain
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: Text(categories[index].title!,
                        style: TextStyle(
                            color: AppStyle.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: CommonTextStyle.smallTextStyle
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        });
  }

}