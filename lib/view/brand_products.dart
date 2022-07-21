import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/model/brand.dart';
import 'package:bk9/view/wishlist.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandProducts extends StatelessWidget {

  IntroController introController = Get.find();
  WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _header(context),
                    SizedBox(height: 30),
                    _body(context),
                    SizedBox(height: 20,)
                  ],
                ),
              )
            ],
          ),
        )
    ));
  }
  _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: AppStyle.getDeviceWidthPercent(100, context),
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
              SizedBox(width: 25),
              Container(
                width: AppStyle.getDeviceWidthPercent(45, context),
                child: Text("Brands",
                    style: TextStyle(
                      fontSize: CommonTextStyle.mediumTextStyle,
                      color: AppStyle.darkGrey,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ///search delegate
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
                      Get.to(() => Wishlist());
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
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
  _productsList(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: introController.brands.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                  onTap:  (){
                    // shopController.loading.value = true;
                    // API.checkInternet().then((internet) {
                    //   if(internet) {
                    //     API.getProductInfo(subCategories[shopController.selectedSubCategory.value].posts![index].id).then((value) {
                    //       Get.to(()=> ProductInformation(value!.product![0]));
                    //       shopController.loading.value = false;
                    //     });
                    //   }
                    // });
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
                                      image: NetworkImage(introController.brands[index].image,),
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
                                  // Container(
                                  //   alignment: AlignmentDirectional.topEnd,
                                  //   width: AppStyle.getDeviceWidthPercent(60, context),
                                  //   child: Obx(() =>
                                  //       GestureDetector(
                                  //         onTap: () {
                                  //           wishListController.wishlistFunction(subCategories[shopController.selectedSubCategory.value].posts![index], context);
                                  //         },
                                  //         child: Icon(
                                  //           subCategories[shopController.selectedSubCategory.value].posts![index].favorite.value
                                  //               ? Icons.favorite
                                  //               : Icons.favorite_border,
                                  //           color: Colors.grey,
                                  //           size: 23,
                                  //         ),
                                  //       ),),),
                                  Container(
                                    width: AppStyle.getDeviceWidthPercent(55, context),
                                    child: Text(introController.brands[index].title.toString(),
                                        maxLines: 2,
                                        style: CommonTextStyle.textStyleForDarkGreyMediumButton
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("AED " + introController.brands[index].price.toString(),
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