import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/controller/productInfo_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/model/product.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/headers/product_header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductInformation extends StatelessWidget {

  Product product;
  ProductInformation(this.product){
    productInfoController.selectedColorIndex.value = 0;
    productInfoController.product = product;
    productInfoController.onStartInit();
    productInfoController.onSelectOption();
  }

  MainPageController mainPageController = Get.find();
  ShopController shopController = Get.find();
  IntroController introController = Get.find();
  ProductInfoController productInfoController = Get.find();
  CartController cartController = Get.find();

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
                      SizedBox(height: AppStyle.getDeviceHeightPercent(10, context)),
                      SizedBox(height: 20),
                      _body(context),
                      SizedBox(height: 20),
                    ],
                  )
              ),
              productInfoController.loading.value ?
              Positioned(child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(color: AppStyle.primary,),
                ),
              )) : Center(),
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
      text: product.title,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: AppStyle.getDeviceHeightPercent(13, context),
                ),
                child:  product.colorsImages!.length ==0 || product.colorsImages![productInfoController.getIndexColorImages(product.colors![productInfoController.selectedColorIndex.value].colorId,product.colorsImages!)].images!.length == 0
                    || product.media!.length == 0  ? Container(
                  width: AppStyle.getDeviceWidthPercent(85, context),
                  height: AppStyle.getDeviceHeightPercent(25, context),
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.fill,
                      )),
                )
                    :
                _productImages(context),
              ),
              product.regularPrice == -1?
              Positioned(
                top: 25,
                left: 0,
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
                top: AppStyle.getDeviceHeightPercent(22, context),
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
                              child: Text(product.title,
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
                                  ///
                                },
                                child: Icon(
                                  product.favorite.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppStyle.grey,
                                  size: 23,
                                )))
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(product.subTitle.toString(),
                          maxLines: 2,
                          style: TextStyle(
                              color: AppStyle.productGrey,
                              fontSize: CommonTextStyle.smallTextStyle,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10,),
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
                                  child: Text("AED " + product.price.toString(),
                                    style: CommonTextStyle.textStyleForWhiteSmallButton,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            product.regularPrice != -1?
                            Text("was AED " + product.regularPrice.toString(),
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: CommonTextStyle.tinyTextStyle,
                                  decoration: TextDecoration.lineThrough
                              ),
                            ) : Text(""),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          product.sizes!.length == 0 || product.colors!.length == 0 || product.weights!.length == 0 ?
          Center() :
          _colorsSizedWeight(context),
          SizedBox(height: product.stringDescription == "" ? 0 : 20),
          _description(context),
          SizedBox(height:  product.sizes!.length == 0 || product.colors!.length == 0 || product.weights!.length == 0 ? 0 : 20),
          _addToCart(context,shopController.selectedSubCategory.value),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  _productImages(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(85, context),
      height: AppStyle.getDeviceHeightPercent(25, context),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: productInfoController.carouselController,
                options: CarouselOptions(
                    height: AppStyle.getDeviceHeightPercent(25, context),
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlayInterval: Duration(seconds: 2),
                    onPageChanged: (index2, reason) {
                      productInfoController.setIndex(index2);
                    }),
                itemCount: product.colorsImages!.length ==0 || product.colorsImages![productInfoController.getIndexColorImages(product.colors![productInfoController.selectedColorIndex.value].colorId,product.colorsImages!)  ].images!.length == 0 ?
                    product.media!.length :
                product.colorsImages![productInfoController.getIndexColorImages(product.colors![productInfoController.selectedColorIndex.value].colorId,product.colorsImages!)].images!.length,
                itemBuilder: (BuildContext context, int photoIndex, int realIndex) {
                  return Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height: AppStyle.getDeviceHeightPercent(25, context),
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(product.colorsImages!.length ==0 || product.colorsImages![productInfoController.getIndexColorImages(product.colors![productInfoController.selectedColorIndex.value].colorId,product.colorsImages!)  ].images!.length == 0 ?
                          product.media![photoIndex].link :
                              product.colorsImages![productInfoController.getIndexColorImages(product.colors![productInfoController.selectedColorIndex.value].colorId,product.colorsImages!)  ].images![photoIndex].link),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          product.sizes!.length == 0 ? Center() :
          Container(
            width: AppStyle.getDeviceWidthPercent(28, context),
            decoration: BoxDecoration(
              color: AppStyle.greyButton,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 3,
                    offset: Offset(1,3),
                    spreadRadius: 0
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Size*",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: CommonTextStyle.tinyTextStyle
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 22,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                            value: productInfoController.sizeValue.value == "" ? product.sizes![0].title : productInfoController.sizeValue.value,
                            onChanged: (newValue) {
                              productInfoController.onSelectOption();
                              productInfoController.sizeValue.value = newValue.toString();
                            },
                            items: product.sizes!.map((value) =>
                                DropdownMenuItem(
                                  value: value.title,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.title,
                                        style: const TextStyle(
                                          color: AppStyle.productGrey,
                                          fontSize: CommonTextStyle.mediumTextStyle,
                                          fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                                .toList(),
                            alignment: Alignment.center,
                            buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          product.colors!.length == 0 ? Center() :
          GestureDetector(
            onTap: () {
              //
            },
            child: Container(
              width: AppStyle.getDeviceWidthPercent(28, context),
              decoration: BoxDecoration(
                color: AppStyle.greyButton,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 3,
                      offset: Offset(1,3),
                      spreadRadius: 0
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Color*",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: CommonTextStyle.tinyTextStyle
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 22,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                              value: productInfoController.colorValue.value == "" ? product.colors![0].title :
                              productInfoController.colorValue.value,
                              onChanged: (newValue) {
                                productInfoController.onSelectOption();
                                productInfoController.selectedColorIndex.value =  productInfoController.getIndex(newValue.toString(),product.colors!);
                                productInfoController.colorValue.value = newValue.toString();
                              },
                              items: product.colors!.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem.title,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        valueItem.title,
                                        style: TextStyle(
                                            color: AppStyle.productGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              alignment: Alignment.center,
                              buttonPadding: EdgeInsets.symmetric(horizontal: 16),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          product.weights!.length == 0 ? Center() :
          Container(
            width: AppStyle.getDeviceWidthPercent(30, context),
            decoration: BoxDecoration(
              color: AppStyle.greyButton,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 3,
                    offset: Offset(1,3),
                    spreadRadius: 0
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Weight*",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: CommonTextStyle.tinyTextStyle
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 22,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                            value: productInfoController.weightValue.value == "" ? product.weights![0].title : productInfoController.weightValue.value,
                            onChanged: (newValue) {
                              productInfoController.onSelectOption();
                              productInfoController.weightValue.value = newValue.toString();
                            },
                            items: product.weights!.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem.weightId == -1 ? "" : valueItem.title,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      valueItem.title,
                                      style: TextStyle(
                                          color: AppStyle.productGrey,
                                          fontSize: CommonTextStyle.mediumTextStyle,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            alignment: Alignment.center,
                            buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _description(BuildContext context) {
    return product.stringDescription == "" ? Text("") :
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
                height: AppStyle.getDeviceHeightPercent(20, context),
                child: SingleChildScrollView(
                  controller: productInfoController.scrollController,
                  child: Text(product.stringDescription.toString(),
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: CommonTextStyle.smallTextStyle,
                        letterSpacing: 0.5
                    ),
                  ),
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
      width: AppStyle.getDeviceWidthPercent(85, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      if (productInfoController.counter.value < product.availability) {
                        productInfoController.increase();
                      }
                    },
                    child: Icon(Icons.add,color: Colors.grey[500],size: 20,),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
              text: "Add to cart",
              onPressed: () {

                cartController.addToCart(product.options![productInfoController.selectedOption.value],productInfoController.counter.value,context);
              },
              color: AppStyle.primary,
              borderRadius: 30,
              border: Colors.transparent,
              width: AppStyle.getDeviceWidthPercent(57, context),
              height: AppStyle.getDeviceHeightPercent(6, context),
              textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
          ),
        ],
      ),
    );
  }
}