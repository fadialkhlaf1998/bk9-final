import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/controller/productInfo_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/model/product.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/headers/product_header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductInformation extends StatelessWidget {

  Product? product ;
  // ProductInformation(this.product){
  //   productInfoController.selectedColorIndex.value = 0;
  //   productInfoController.product = product;
  //   productInfoController.onStartInit();
  //   productInfoController.onSelectOption();
  // }

  ProductInformation(int id){
    productInfoController.loading.value=true;
    API.getProductInfo(id).then((value) {
      if(value == null){
        Get.back();
        //todo error msg
        return ;
      }
      product =value.product![0];
      // Get.to(()=> ProductInformation());
      shopController.loading.value = false;
      productInfoController.selectedColorIndex.value = 0;
      productInfoController.product = product;
      productInfoController.onStartInit();
      productInfoController.onSelectOption();
      productInfoController.loading.value = false;
    });

  }

  MainPageController mainPageController = Get.find();
  ShopController shopController = Get.find();
  IntroController introController = Get.find();
  ProductInfoController productInfoController = Get.find();
  CartController cartController = Get.find();
  WishListController wishListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => SafeArea(
          child: productInfoController.loading.value ?
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(color: AppStyle.primary,),
            ),
          ) : Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 90),
                      // SizedBox(height: 20),
                      _body(context),
                      SizedBox(height: 20),
                    ],
                  )
              ),
              Positioned(
                top: 0,
                child: _header(shopController.selectedSubCategory.value),
              ),

            ],
          )
        ))
    );
  }

  _header(int index) {
    return ProductHeader(
      text: product!.title,
      textStyle: CommonTextStyle.textStyleForDarkGreyMediumButton,
      onTap: () {
        Get.back();
      },
      mainPageController: mainPageController,
      introController: introController,
    );
  }
  _body(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      // height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-70,
      // color: Colors.red,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: AppStyle.getDeviceWidthPercent(100, context),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: AppStyle.getDeviceHeightPercent(13, context),
                        ),
                        child:  product!.colorsImages!.length ==0 || product!.colorsImages![productInfoController.getIndexColorImages(product!.colors![productInfoController.selectedColorIndex.value].colorId,product!.colorsImages!)].images!.length == 0
                            || product!.media!.length == 0  ? Container(
                          width: AppStyle.getDeviceWidthPercent(85, context),
                          height: AppStyle.getDeviceWidthPercent(85, context),
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: NetworkImage(product!.image),
                                fit: BoxFit.fill,
                              )),
                        )
                            :
                        _productImages(context),
                      ),
                    ),
                  ),
                  product!.regularPrice >0?
                  Positioned(
                    top: 25,
                    left: AppStyle.getDeviceWidthPercent(7.5, context),
                    child: Container(
                      color: AppStyle.red,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                          child: Text("Deal",
                              style: TextStyle(color: Colors.white,fontSize: CommonTextStyle.tinyTextStyle)),
                        ),
                      ),
                    ),
                  ):const Text(""),
                  Positioned(
                    top: AppStyle.getDeviceWidthPercent(85, context)-25,
                    child: Container(
                      width: AppStyle.getDeviceWidthPercent(85, context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 3,
                              offset: Offset(1,0),
                              spreadRadius: 1
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: AppStyle.getDeviceWidthPercent(63, context),
                                  child: Text(product!.title,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: AppStyle.darkGrey,
                                      fontSize: CommonTextStyle.smallTextStyle,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Obx(() => GestureDetector(
                                    onTap: () {
                                      //todo add wishlist function

                                      Post p = Post(id: product!.id, parent1: -1, parent2: -1, parent3: -1, parent4: -1, parent5: -1, postTypeId: product!.postTypeId,
                                          publish: 1, search: "", title: product!.title, subTitle: product!.subTitle, image: product!.image, sku: product!.sku, slug: product!.slug, price: product!.price!.toDouble(), regularPrice: product!.regularPrice.toDouble(), likes: product!.likes, availability:product!.availability,
                                          companyId: product!.companyId, metaTitle:product!. metaTitle, metaDescription:product!. metaDescription, position: product!.position, locale: "",
                                          languageParent: product!.languageParent, rate: product!.rate, stringDescription: product!.stringDescription, wishlist: product!.wishlist,
                                          media: null, review: null, jsonData: null, count: 0, favorite: product!.wishlist ==1?true.obs:false.obs, my_rate: product!.myRate.toDouble(), cartCount: 0.obs, posts: null, color: Colors.red);
                                      wishListController.wishlistFunction(p,context);
                                      product!.favorite.value = ! product!.favorite.value;
                                      print(product!.favorite.value);
                                    },
                                    child: Icon(
                                      product!.favorite.value
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: AppStyle.grey,
                                      size: 23,
                                    )))
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text(product!.subTitle.toString(),
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppStyle.productGrey,
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: AppStyle.lightOrange
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                        child: Center(
                                          child: Text("AED " + product!.price.toString(),
                                            style: CommonTextStyle.textStyleForWhiteSmallButton,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    product!.regularPrice > 0?
                                    Text("was AED " + product!.regularPrice.toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: CommonTextStyle.tinyTextStyle,
                                          decoration: TextDecoration.lineThrough
                                      ),
                                    ) : Text(""),
                                  ],
                                ),
                                Container(
                                  width: 70,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: AppStyle.primary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FittedBox(
                                        child: Text(product!.rate.toStringAsFixed(2),style: TextStyle(color: Colors.white),),
                                      ),
                                      Icon(Icons.star,color: Colors.white,size: 20,)
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // product!.sizes!.length == 0 || product!.colors!.length == 0 || product!.weights!.length == 0 ?
              // Center() :
              SizedBox(height: 20),
              _colorsSizedWeight(context),
              SizedBox(height: product!.stringDescription == "" ? 0 : 20),
              _description(context),
              SizedBox(height: 20),
              _addToCart(context,shopController.selectedSubCategory.value),
              SizedBox(height: 20),
              _rate(context),
              SizedBox(height: 20),
              _review(context),
              SizedBox(height: AppStyle.getDeviceHeightPercent(7, context),)


            ],
          ),
        ),
      ),
    );
  }
  _rate(BuildContext context){
    return RatingBar.builder(
      initialRating: product!.myRate.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating.toInt());
        productInfoController.rateProduct(rating.toInt());
      },
    );
  }
  _review(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          child: Column(
            children: [
              Stack(
                children: [
                  Container( width: MediaQuery.of(context).size.width*0.9,),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width*0.9-65,
                    child: TextField(
                      controller: productInfoController.review,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(color: Colors.black,fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: AppStyle.primary)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: AppStyle.primary)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: AppStyle.primary)
                        ),
                        hintText: 'Review',
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          productInfoController.reviewProduct(context);
                        },
                        child: Container(
                    height: 45,
                    width: 70,
                    color: AppStyle.primary,
                    child: Center(
                        child: Text("Post",style: TextStyle(color: Colors.white)),
                    ),
                  ),
                      ),)
                ],
              ),
              SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true,
                  itemCount: product!.review!.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product!.review![index].firstname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          product!.review![index].rate==0?Center():RatingBar.builder(
                            initialRating: product!.review![index].rate.toDouble(),
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            tapOnlyMode: false,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 17,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 50,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(product!.review![index].body,style: TextStyle(fontSize: 14),),
                      SizedBox(height: 5,),
                      Divider(height: 1,color: Colors.black),
                      SizedBox(height: 5,),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
  _productImages(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(85, context),
      height:AppStyle.getDeviceWidthPercent(85, context),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: productInfoController.carouselController,
                options: CarouselOptions(
                    height: AppStyle.getDeviceWidthPercent(85, context),
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlayInterval: Duration(seconds: 2),
                    onPageChanged: (index2, reason) {
                      productInfoController.setIndex(index2);
                    }),
                itemCount: product!.colorsImages!.length ==0 || product!.colorsImages![productInfoController.getIndexColorImages(product!.colors![productInfoController.selectedColorIndex.value].colorId,product!.colorsImages!)  ].images!.length == 0 ?
                    product!.media!.length :
                product!.colorsImages![productInfoController.getIndexColorImages(product!.colors![productInfoController.selectedColorIndex.value].colorId,product!.colorsImages!)].images!.length,
                itemBuilder: (BuildContext context, int photoIndex, int realIndex) {
                  return Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height:AppStyle.getDeviceWidthPercent(85, context),
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(product!.colorsImages!.length ==0 || product!.colorsImages![productInfoController.getIndexColorImages(product!.colors![productInfoController.selectedColorIndex.value].colorId,product!.colorsImages!)  ].images!.length == 0 ?
                          product!.media![photoIndex].link :
                              product!.colorsImages![productInfoController.getIndexColorImages(product!.colors![productInfoController.selectedColorIndex.value].colorId,product!.colorsImages!)  ].images![photoIndex].link),
                          fit: BoxFit.fill,
                        )),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  _colorsSizedWeight(BuildContext context) {

    return Container(
      width: AppStyle.getDeviceWidthPercent(90, context),
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        runSpacing: 10,
        spacing: MediaQuery.of(context).size.width*0.05,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          product!.sizes!.length == 0 ||product!.sizes==null? Center() :
          _sizesList(context),
          // Container(
          //   width: AppStyle.getDeviceWidthPercent(40, context),
          //   decoration: BoxDecoration(
          //     color: AppStyle.greyButton,
          //     borderRadius: BorderRadius.circular(30),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.grey.withOpacity(0.3),
          //           blurRadius: 3,
          //           offset: Offset(1,3),
          //           spreadRadius: 0
          //       ),
          //     ],
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text("Select Size*",
          //             style: TextStyle(
          //                 color: Colors.grey,
          //                 fontSize: CommonTextStyle.tinyTextStyle
          //             )
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //               height: 22,
          //               child: DropdownButtonHideUnderline(
          //                 child: DropdownButton2(
          //                   icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
          //                   value: productInfoController.sizeValue.value == "" ? product!.sizes![0].title : productInfoController.sizeValue.value,
          //                   onChanged: (newValue) {
          //                     productInfoController.selectedSizeId.value =  productInfoController.getSizeId(newValue.toString(),product!.sizes!);
          //                     productInfoController.sizeValue.value = newValue.toString();
          //                     productInfoController.onSelectOption();
          //
          //                   },
          //                   items: product!.sizes!.map((value) =>
          //                       DropdownMenuItem(
          //                         value: value.title,
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               value.title,
          //                               style: const TextStyle(
          //                                 color: AppStyle.productGrey,
          //                                 fontSize: CommonTextStyle.mediumTextStyle,
          //                                 fontWeight: FontWeight.normal
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ))
          //                       .toList(),
          //                   alignment: Alignment.center,
          //                   buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          //                   dropdownDecoration: BoxDecoration(
          //                     borderRadius: BorderRadius.only(
          //                       bottomLeft: Radius.circular(30),
          //                       bottomRight: Radius.circular(30),
          //                     ),
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          product!.colors!.length == 0 ||product!.colors==null? Center() :
          _colorList(context),
          // GestureDetector(
          //   onTap: () {
          //     //
          //   },
          //   child: Container(
          //     width: AppStyle.getDeviceWidthPercent(40, context),
          //     decoration: BoxDecoration(
          //       color: AppStyle.greyButton,
          //       borderRadius: BorderRadius.circular(30),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.grey.withOpacity(0.3),
          //             blurRadius: 3,
          //             offset: Offset(1,3),
          //             spreadRadius: 0
          //         ),
          //       ],
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text("Select Color*",
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontSize: CommonTextStyle.tinyTextStyle
          //               )
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: 22,
          //                 child: DropdownButtonHideUnderline(
          //                   child: DropdownButton2(
          //                     icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
          //                     value: productInfoController.colorValue.value == "" ? product!.colors![0].title :
          //                     productInfoController.colorValue.value,
          //                     onChanged: (newValue) {
          //                       productInfoController.selectedColorIndex.value =  productInfoController.getIndex(newValue.toString(),product!.colors!);
          //                       productInfoController.selectedColorId.value =  productInfoController.getColorId(newValue.toString(),product!.colors!);
          //                       productInfoController.colorValue.value = newValue.toString();
          //                       productInfoController.onSelectOption();
          //                     },
          //                     items: product!.colors!.map((valueItem) {
          //                       return DropdownMenuItem(
          //                         value: valueItem.title,
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               valueItem.title,
          //                               style: TextStyle(
          //                                   color: AppStyle.productGrey,
          //                                   fontSize: CommonTextStyle.mediumTextStyle,
          //                                   fontWeight: FontWeight.normal
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     }).toList(),
          //                     alignment: Alignment.center,
          //                     buttonPadding: EdgeInsets.symmetric(horizontal: 16),
          //                     dropdownDecoration: BoxDecoration(
          //                       borderRadius: BorderRadius.only(
          //                         bottomLeft: Radius.circular(30),
          //                         bottomRight: Radius.circular(30),
          //                       ),
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          product!.weights!.length == 0 ||product!.weights==null? Center() :
          _weightList(context),
          // Container(
          //   width: AppStyle.getDeviceWidthPercent(40, context),
          //   decoration: BoxDecoration(
          //     color: AppStyle.greyButton,
          //     borderRadius: BorderRadius.circular(28),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.grey.withOpacity(0.3),
          //           blurRadius: 3,
          //           offset: Offset(1,3),
          //           spreadRadius: 0
          //       ),
          //     ],
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          //     child: Container(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text("Select Weight*",
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontSize: CommonTextStyle.tinyTextStyle
          //               )
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: 22,
          //                 width: AppStyle.getDeviceWidthPercent(40, context)-30,
          //                 child: DropdownButtonHideUnderline(
          //                   child: DropdownButton2(
          //                     icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
          //                     value: productInfoController.weightValue.value == "" ? product!.weights![0].title : productInfoController.weightValue.value,
          //                     onChanged: (newValue) {
          //                       productInfoController.selectedWeightId.value =  productInfoController.getWeightId(newValue.toString(),product!.weights!);
          //                       productInfoController.weightValue.value = newValue.toString();
          //                       productInfoController.onSelectOption();
          //
          //                     },
          //                     items: product!.weights!.map((valueItem) {
          //                       return DropdownMenuItem(
          //                         value: valueItem.weightId == -1 ? "" : valueItem.title,
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Text(
          //                               valueItem.title,
          //                               style: TextStyle(
          //                                   color: AppStyle.productGrey,
          //                                   fontSize: CommonTextStyle.mediumTextStyle,
          //                                   fontWeight: FontWeight.normal
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     }).toList(),
          //                     alignment: Alignment.center,
          //                     buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          //                     dropdownDecoration: BoxDecoration(
          //                       borderRadius: BorderRadius.only(
          //                         bottomLeft: Radius.circular(30),
          //                         bottomRight: Radius.circular(30),
          //                       ),
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  _sizesList(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: 60,
      child: Column(
        children: [
          Text("Select Size"),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: 40,
            child: ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: product!.sizes!.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      productInfoController.selectedSizeId.value =  product!.sizes![index].sizeId;
                      // productInfoController.sizeValue.value = newValue.toString();
                      productInfoController.onSelectOption();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: productInfoController.selectedSizeId.value == product!.sizes![index].sizeId?AppStyle.primary:Colors.grey)
                      ),
                      child: Center(
                        child: Text(product!.sizes![index].title,style: TextStyle(color: productInfoController.selectedSizeId.value == product!.sizes![index].sizeId?AppStyle.primary:Colors.grey),),
                      ),
                    ),
                  );
            }),
          )
        ],
      ),
    );
  }

  _colorList(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: 60,
      child: Column(
        children: [
          Text("Select colors"),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: 40,
            child: ListView.builder(
              // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: product!.colors!.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      productInfoController.selectedColorIndex.value =  productInfoController.selectedColorIndex.value =  productInfoController.getIndex(product!.colors![index].title.toString(),product!.colors!);
                      productInfoController.selectedColorId.value =  product!.colors![index].colorId;
                      // productInfoController.colorValue.value = newValue.toString();
                      productInfoController.onSelectOption();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: productInfoController.selectedColorId.value == product!.colors![index].colorId?AppStyle.primary:Colors.grey)
                      ),
                      child: Center(
                        child: Text(product!.colors![index].title,style: TextStyle(color: productInfoController.selectedColorId.value == product!.colors![index].colorId?AppStyle.primary:Colors.grey),),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  _weightList(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: 60,
      child: Column(
        children: [
          Text("Select Size"),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: 40,
            child: ListView.builder(
              // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: product!.weights!.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      productInfoController.selectedWeightId.value =  product!.weights![index].weightId;
                      // productInfoController.weightValue.value = newValue.toString();
                      productInfoController.onSelectOption();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: productInfoController.selectedWeightId.value == product!.weights![index].weightId?AppStyle.primary:Colors.grey)
                      ),
                      child: Center(
                        child: Text(product!.weights![index].title,style: TextStyle(color: productInfoController.selectedWeightId.value == product!.weights![index].weightId?AppStyle.primary:Colors.grey),),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  _description(BuildContext context) {
    return product!.stringDescription == "" ? Text("") :
      Container(
      width: AppStyle.getDeviceWidthPercent(85, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Product Description",
            style: TextStyle(
                color: AppStyle.productGrey,
                fontSize: CommonTextStyle.mediumTextStyle,
                fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: AppStyle.getDeviceWidthPercent(85, context),
                child: Column(
                  children: [
                    Text(product!.stringDescription.toString(),
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: CommonTextStyle.smallTextStyle,
                          letterSpacing: 0.5
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  _addToCart(BuildContext context,int index) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: AppStyle.getDeviceHeightPercent(7, context),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppStyle.getDeviceWidthPercent(25, context),
            height: AppStyle.getDeviceHeightPercent(6, context),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppStyle.primary)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if(productInfoController.counter.value > 1) {
                          productInfoController.decrease();
                        }
                      },
                      child: Icon(Icons.remove,color: Colors.grey[500],size: 20)),
                  Text( productInfoController.counter.toString(),
                    //introController.superCategory[shopController.selectedSuperCategory.value].posts![shopController.selectedCategory.value].posts![index].cartCount.value.toString(),
                    style: TextStyle(
                        fontSize: CommonTextStyle.smallTextStyle,
                        color: AppStyle.primary
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (productInfoController.counter.value < product!.options![productInfoController.selectedOption.value].stock) {
                        productInfoController.increase();
                      }
                    },
                    child: Icon(Icons.add,color: Colors.grey[500],size: 20,),
                  ),
                ],
              ),
            ),
          ),
    cartController.cart_op_loading.value
    ?
          Container(
                width: AppStyle.getDeviceWidthPercent(57, context),
                height: AppStyle.getDeviceHeightPercent(6, context),
                decoration: BoxDecoration(
                  color: AppStyle.primary,
                  borderRadius: BorderRadius.circular(30)
                ),
                child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(

                    child: CircularProgressIndicator(color: Colors.white,),
                  ),
                )
              ):GestureDetector(
              onTap: (){
                print(productInfoController.selectedOption.value);
                if(productInfoController.selectedOption.value==-1){
                  AppStyle.errorMsg(context,"Out of stock");
                  return;
                }
                cartController.addToCart(product!.options![productInfoController.selectedOption.value],productInfoController.counter.value,context);
              },
      child: Container(
        width: AppStyle.getDeviceWidthPercent(57, context),
        height: AppStyle.getDeviceHeightPercent(6, context),
        decoration: BoxDecoration(
            color: AppStyle.primary,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Center(child: Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold))),
      ),
            ),

        ],
      ),
    );
  }
}