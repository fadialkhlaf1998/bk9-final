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
      print('*-*-*-*-*-*-*');
      print(value.product!.first.id);
      print(value.product!.first.media!.length);
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
          Stack(
            children: [
              BackgroundImage(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(color: AppStyle.primary,),
                ),
              ),
            ],
          ) : Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 90),
                      _body(context),
                      SizedBox(height: 20),
                    ],
                  )
              ),
              Positioned(
                top: 0,
                child: _header(shopController.selectedSubCategory.value),
              ),
              Positioned(
                bottom: 0,
                child: _addToCart(context,shopController.selectedSubCategory.value),
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
                        bottom: AppStyle.getDeviceHeightPercent(12, context),
                      ),
                      child:  (product!.colorsImages!.length ==0 || product!.colorsImages![productInfoController.getIndexColorImages(product!.colors![productInfoController.selectedColorIndex.value].colorId,product!.colorsImages!)].images!.length == 0)
                          && product!.media!.length == 0  ? Container(
                        width: AppStyle.getDeviceWidthPercent(85, context),
                        height: AppStyle.getDeviceWidthPercent(60, context),
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
                Positioned(
                  top: 25,
                  left: 10,
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              /// share
                            },
                            child: Icon(
                              Icons.share,
                              color: AppStyle.darkGrey,
                              size: 25,
                            )),
                        SizedBox(width: 10,),
                        Obx(() => GestureDetector(
                            onTap: () {
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
                              size: 25,
                            )))
                      ],
                    ),
                  ),
                ),
                product!.regularPrice >0?
                Positioned(
                  top: 25,
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: AppStyle.red,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                              child: Text("Deal",
                                  style: TextStyle(color: Colors.white,fontSize: CommonTextStyle.tinyTextStyle)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ):const Text(""),
                Positioned(
                  top: AppStyle.getDeviceWidthPercent(60, context)-25,
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
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
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product!.subTitle.toString(),
                                maxLines: 2,
                                style: TextStyle(
                                    color: AppStyle.productGrey,
                                    fontSize: CommonTextStyle.smallTextStyle,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              _rate(context),
                            ],
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
            _colorsSizedWeight(context),
            SizedBox(height: product!.stringDescription == "" ? 0 : 20),
            _description(context),
            SizedBox(height: 20),
            // _addToCart(context,shopController.selectedSubCategory.value),
            // SizedBox(height: 20),
            _review(context),
            SizedBox(height: AppStyle.getDeviceHeightPercent(6, context),)
          ],
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
      itemSize: 20,
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
      width: AppStyle.getDeviceWidthPercent(100, context),
      child: Center(
        child: Container(
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 55,
                    width: AppStyle.getDeviceWidthPercent(85, context),),
                  Container(
                    height: 55,
                    width: AppStyle.getDeviceWidthPercent(85, context)-70,
                    child: TextField(
                      controller: productInfoController.review,
                      textAlignVertical: TextAlignVertical.bottom,
                      cursorColor: AppStyle.darkGrey,
                      style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: AppStyle.primary),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: AppStyle.primary),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: AppStyle.primary),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
                        ),
                        hintText: 'Review',
                        hintStyle: TextStyle(
                            color: AppStyle.grey,
                            fontSize: CommonTextStyle.mediumTextStyle,
                            fontWeight: FontWeight.normal
                        ),

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
                    height: 55,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppStyle.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                      )
                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product!.review![index].firstname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: CommonTextStyle.mediumTextStyle
                            ),),
                          product!.review![index].rate==0?Center():RatingBar.builder(
                            initialRating: product!.review![index].rate.toDouble(),
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            tapOnlyMode: false,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 16,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(product!.review![index].body,
                        style: TextStyle(
                            fontSize: CommonTextStyle.smallTextStyle,
                        ),),
                      SizedBox(height: 10,),
                      Divider(height: 1,color: Colors.black),
                      SizedBox(height: 10,),
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
      height: AppStyle.getDeviceWidthPercent(60, context),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: productInfoController.carouselController,
                options: CarouselOptions(
                    height: AppStyle.getDeviceWidthPercent(60, context),
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
                  print('-----------');
                  return Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height: AppStyle.getDeviceWidthPercent(60, context),
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
      width: AppStyle.getDeviceWidthPercent(85, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product!.sizes!.length == 0 ||product!.sizes==null? Center() :
          _sizesList(context),
          SizedBox(height: 5),
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
          SizedBox(height: 5),
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
      width: AppStyle.getDeviceWidthPercent(85, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Size*"),
          SizedBox(height: 5),
          Container(
            width: AppStyle.getDeviceWidthPercent(85, context),
            height: 35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product!.sizes!.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      productInfoController.selectedSizeId.value =  product!.sizes![index].sizeId;
                      // productInfoController.sizeValue.value = newValue.toString();
                      productInfoController.onSelectOption();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: productInfoController.selectedSizeId.value == product!.sizes![index].sizeId?AppStyle.primary:Colors.grey)
                        ),
                        child: Center(
                          child: Text(product!.sizes![index].title,style: TextStyle(color: productInfoController.selectedSizeId.value == product!.sizes![index].sizeId?AppStyle.primary:Colors.grey),),
                        ),
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
      width: AppStyle.getDeviceWidthPercent(85, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select color*"),
          SizedBox(height: 5),
          Container(
            width: AppStyle.getDeviceWidthPercent(85, context),
            height: 35,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: productInfoController.selectedColorId.value == product!.colors![index].colorId?AppStyle.primary:Colors.grey)
                        ),
                        child: Center(
                          child: Text(product!.colors![index].title,style: TextStyle(color: productInfoController.selectedColorId.value == product!.colors![index].colorId?AppStyle.primary:Colors.grey),),
                        ),
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
      width: AppStyle.getDeviceWidthPercent(85, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Size*"),
          SizedBox(height: 5),
          Container(
            width: AppStyle.getDeviceWidthPercent(85, context),
            height: 35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product!.weights!.length,
                itemBuilder: (context,index){
                  return Obx(() => GestureDetector(
                      onTap: (){
                        productInfoController.selectedWeightId.value =  product!.weights![index].weightId;
                        // productInfoController.weightValue.value = newValue.toString();
                        productInfoController.onSelectOption();
                        print(productInfoController.selectedWeightId.value);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: productInfoController.selectedWeightId.value == product!.weights![index].weightId?AppStyle.primary:Colors.grey)
                          ),
                          child: Center(
                            child: Text(product!.weights![index].title,style: TextStyle(color: productInfoController.selectedWeightId.value == product!.weights![index].weightId?AppStyle.primary:Colors.grey),),
                          ),
                        ),
                      )
                  ));
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
      height: 65,
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
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              child: Container(
                height: AppStyle.getDeviceHeightPercent(6, context),
                width: AppStyle.getDeviceWidthPercent(57, context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppStyle.primary,
                    onPrimary: AppStyle.primary,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: FittedBox(
                    child: cartController.cart_op_loading.value ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(color: Colors.white,),
                    ) :
                    Text("Add To Cart",
                        style: CommonTextStyle.textStyleForOrangeMediumButtonBold  // this.textStyle,
                    ),
                  ),
                  onPressed: () {
                    print(productInfoController.selectedOption.value);
                    if(productInfoController.selectedOption.value==-1){
                      AppStyle.errorMsg(context,"Out of stock");
                      return;
                    }
                    cartController.addToCart(product!.options![productInfoController.selectedOption.value],productInfoController.counter.value,context);
                  },
                ),
              ),
            ),
            ),
        ],
      ),
    );
  }
}