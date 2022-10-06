import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/product_filter_controller.dart';
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

class ProductFilter extends StatelessWidget {


  ShopController shopController = Get.find();
  IntroController introController = Get.find();
  WishListController wishListController = Get.find();
  ProductFilterController productFilterController = Get.put(ProductFilterController());
  
  List<Post> posts;
  String title;
  ProductFilter(this.posts,this.title) {
    bool succ=wishListController.refreshProduct(posts);
    if(succ){
      productFilterController.posts.value = posts;
      for(int i=0 ; i < productFilterController.posts.value.length ; i ++) {
        print('////////////////////////');
        print(productFilterController.posts[i].favorite.value);
      }
    }
    // Future.delayed(Duration(milliseconds: 500)).then((value) {
    //
    // });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              shopController.fake.value ? Center() : Center(),
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
                          child:  CustomFilterSort(shopController: shopController,off: true,productFilterController: productFilterController),
                        ),
                        _header(context, shopController.selectedCategory.value)
                      ],
                    ),
                    SizedBox(height: 20,),
                    productFilterController.loading.value ? CircularProgressIndicator(color: Colors.white,):
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
                SizedBox(width: 25),
                Text(title,
                    style: CommonTextStyle.textStyleForDarkGreyMediumButton
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
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
        )
    );
  }
  _productsList(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height - 150) - Get.bottomBarHeight,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: productFilterController.posts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // print( productFilterController.posts.length);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                  onTap:  (){
                    Get.to(()=> ProductInformation(productFilterController.posts[index].id))!.then((value) {
                      bool succ=wishListController.refreshProduct(posts);
                      if(succ){
                        for(int i=0 ; i < productFilterController.posts.value.length ; i ++) {
                          print('////////////////////////');
                          print(productFilterController.posts[i].favorite.value);
                        }
                      }
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
                                      image: NetworkImage(productFilterController.posts[index].image!,),
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
                                            wishListController.wishlistFunction(productFilterController.posts[index], context);
                                          },
                                          child: Icon(
                                            productFilterController.posts[index].favorite.value
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.grey,
                                            size: 23,
                                          ),
                                        ),),),
                                  Container(
                                    width: AppStyle.getDeviceWidthPercent(55, context),
                                    child: Text(productFilterController.posts[index].title.toString(),
                                        maxLines: 2,
                                        style: CommonTextStyle.textStyleForDarkGreyMediumButton
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("AED " + productFilterController.posts[index].price.toString(),
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