import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/view/product_info.dart';
import 'package:bk9/view/services_details.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_gridView_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchView extends StatelessWidget {

  IntroController introController = Get.find();
  WishListController wishListController  = Get.find();
  List<Post> products = <Post>[];
  List<Post> service = <Post>[];
  List<String> postTypes = <String>[];

  CustomSearchView(this.products, this.service);

  @override
  Widget build(BuildContext context) {
    postTypes = ["products", "services"];
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
                    const SizedBox(height: 10),
                    _body(context),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
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
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,size: 23,)
              ),
              SizedBox(width: 25),
              Container(
                width: AppStyle.getDeviceWidthPercent(45, context),
                child: Text("seach results",
                    style: TextStyle(
                      fontSize: CommonTextStyle.mediumTextStyle,
                      color: AppStyle.darkGrey,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 3),
              child: ContainerWithImage(
                  width: 40,
                  height: 70,
                  image: "assets/icons/wishlist.svg",
                  color: Colors.transparent,
                  option: 0)
          )
        ],
      ),
    );
  }
  _body(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 20,),
        _posts(context),
        introController.selectedPostFilter.value == 0 ?
        _productList(context) : _servicesList(context)
      ],
    );
  }
  _servicesList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CustomGridViewServices(
        count: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        padding: 4,
        introController: introController,
      ),
    );
  }
  _productList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: products.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                  onTap:  (){
                    // introController.goToProductPage(products[index].id);
                    Get.to(()=> ProductInformation(products[index].id))!.then((value) {
                      wishListController.refreshProduct(products);
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
                                      image: NetworkImage(products[index].image.toString()),
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
                                            wishListController.wishlistFunction(products[index], context);
                                          },
                                          child: Icon(
                                            products[index].favorite.value
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.grey,
                                            size: 23,
                                          ),
                                        ),),),
                                  Container(
                                    width: AppStyle.getDeviceWidthPercent(50, context),
                                    child: Text(products[index].title.toString(),
                                        maxLines: 2,
                                        style: CommonTextStyle.textStyleForDarkGreyMediumButton
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("AED " + products[index].price.toString(),
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
  _posts(BuildContext context){
    return Container(
      width: AppStyle.getDeviceWidthPercent(85, context),
      height: AppStyle.getDeviceHeightPercent(4, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: postTypes.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: (){
                      introController.selectedPostFilter.value = index;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(postTypes[index]+" ("+ (index==0 ? products.length.toString() :
                        service.length.toString())+")",
                            style: CommonTextStyle.textStyleForGreySmallButton
                        ),
                        Container(
                          color: index == introController.selectedPostFilter.value ?
                          AppStyle.primary : AppStyle.grey,
                          width: 120,
                          height: 2,
                        ),
                      ],
                    ),
                  )
                );
          }),
        ],
      ),
    );
  }

}
