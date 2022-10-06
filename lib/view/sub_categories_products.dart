import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/view/product_info.dart';
import 'package:bk9/view/wishlist.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_filter_sort.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesProducts extends StatelessWidget {

  List<Post> subCategories;
  SubCategoriesProducts(this.subCategories){
    shopController.selectedSubCategory.value = 0;
    shopController.productsView.value = subCategories[shopController.selectedSubCategory.value].posts!;
    wishListController.refreshProduct(subCategories[shopController.selectedSubCategory.value].posts!);
  }


  ShopController shopController = Get.find();
  IntroController introController = Get.find();
  WishListController wishListController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 110,
                          color: AppStyle.primary,
                        ),
                        Positioned(
                          bottom: 0,
                          child:  CustomFilterSort(shopController: shopController,off: false),
                        ),
                        _header(context, shopController.selectedCategory.value)
                      ],
                    ),
                    SizedBox(height: 20,),
                    _subCartegoryList(context),
                    SizedBox(height: 20,),
                    _productsList(context),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              shopController.loading.value ?
              Positioned(child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(color: AppStyle.primary,),
                ),
              )) : Center()
            ],
          ),
        ))
    );
  }

  _header(BuildContext context,int index) {
    return  Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: AppStyle.getDeviceWidthPercent(100, context),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 1,
              offset: Offset(5.0, 5.0,),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back,size: 23,)
                ),
                SizedBox(width: 25,),
                Container(
                  width: AppStyle.getDeviceWidthPercent(50, context),
                  child: Text(introController.superCategory[shopController.selectedSuperCategory.value].posts![index].title!,
                      style: CommonTextStyle.textStyleForDarkGreyMediumButton
                  ),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    introController.pressedOnSearch(context);
                  },
                  child: Container(
                      height: AppStyle.getDeviceHeightPercent(5, context),
                      width: AppStyle.getDeviceWidthPercent(10.5, context),
                      decoration: BoxDecoration(
                        color: AppStyle.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: ContainerWithImage(
                            width: 20,
                            height: 20,
                            image: "assets/icons/search.svg",
                            color: Colors.white,
                            option: 0
                        ),
                      )
                  ),
                ),
                SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => Wishlist())!.then((value) {
                          wishListController.refreshProduct(subCategories[shopController.selectedSubCategory.value].posts!);
                        });
                      },
                      child: ContainerWithImage(
                          width: 40,
                          height: 70,
                          image: "assets/icons/wishlist.svg",
                          color: AppStyle.grey,
                          option: 0)
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
  _subCartegoryList(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(90, context),
      height: AppStyle.getDeviceHeightPercent(13, context),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subCategories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Obx(() => GestureDetector(
              onTap:  (){
                shopController.selectedSubCategory.value = index;
                shopController.productsView.value = subCategories[shopController.selectedSubCategory.value].posts!;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color:shopController.selectedSubCategory.value == index ? AppStyle.primary : Colors.grey,
                        width: 1.5
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: AppStyle.getDeviceWidthPercent(32, context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(subCategories[index].image!,),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: AppStyle.getDeviceWidthPercent(30, context),
                          child: Center(
                            child: Text(subCategories[index].title!,
                              maxLines: 2,
                              style: TextStyle(
                                color: AppStyle.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: CommonTextStyle.tinyTextStyle,
                                overflow: TextOverflow.ellipsis
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,)
                    ],
                  ),
                ),
              ),
            ));
          }),
    );
  }
  _productsList(BuildContext context) {
    return Container(
      height: Get.height * 0.85-170,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: shopController.productsView.length,
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // print( subCategories[shopController.selectedSubCategory.value].posts!.length);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap:  (){
                  Get.to(()=> ProductInformation(shopController.productsView[index].id))!.then((value) {
                    wishListController.refreshProduct(subCategories[shopController.selectedSubCategory.value].posts!);
                    });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: AppStyle.getDeviceWidthPercent(100, context),
                      // height: AppStyle.getDeviceHeightPercent(13, context),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0,3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: AppStyle.getDeviceHeightPercent(12, context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(shopController.productsView[index].image!,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: AlignmentDirectional.topEnd,
                                  width: AppStyle.getDeviceWidthPercent(60, context),
                                  child: Obx(() =>
                                      GestureDetector(
                                        onTap: () {
                                          wishListController.wishlistFunction(shopController.productsView[index], context);
                                        },
                                        child: Icon(
                                          shopController.productsView[index].favorite.value
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.grey,
                                          size: 23,
                                        ),
                                      ),),),
                                Container(
                                  width: AppStyle.getDeviceWidthPercent(55, context),
                                  child: Text(shopController.productsView[index].title.toString(),
                                    maxLines: 2,
                                    style: CommonTextStyle.textStyleForDarkGreyMediumButton
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text("AED " + shopController.productsView[index].price.toString(),
                                  style: CommonTextStyle.textStyleForGreySmallButton,
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            );
          }),
    );
  }

}