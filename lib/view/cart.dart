import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/controller/productInfo_controller.dart';
import 'package:bk9/model/product.dart';
import 'package:bk9/view/checkout.dart';
import 'package:bk9/view/wishlist.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {

  CartController cartController = Get.put(CartController());
  MainPageController mainPageController = Get.find();
  ProductInfoController productInfoController = Get.put(ProductInfoController());

  Cart(){
    cartController.getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Stack(
          children: [
            BackgroundImage(),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _header(context),
                  SizedBox(height: 30),
                  API.customer_id == -1 || cartController.cart.isEmpty ?
                  _emptyCart(context) :
                  _notEmptyCart(context),
                  SizedBox(height: 20,)
                ],
              ),
            ),
            cartController.loading.value ?
            Positioned(child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: AppStyle.primary,),
              ),
            )) : Center()
          ],
        ))
    );
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
                      mainPageController.changeIndexOfBottomBar(0);
                    },
                    child: Icon(Icons.arrow_back,size: 23,)
                ),
                SizedBox(width: 25),
                Container(
                  width: AppStyle.getDeviceWidthPercent(45, context),
                  child: Text(
                      cartController.cart.isEmpty ?
                      "Cart" :
                      "Cart " + "( " + cartController.cart.length.toString() + " Product" + " )",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: CommonTextStyle.mediumTextStyle,
                        color: AppStyle.grey,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ],
            ),
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
    );
  }
  _emptyCart(BuildContext context) {
    return Column(
      children: [
        TextApp(text: "Your Shopping Cart Is Empty",
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(8, context),
            textStyle: CommonTextStyle.textStyleForDarkGreySmallButtonBold
        ),
        SvgPicture.asset("assets/icons/cart.svg",width: 50,height: 50,color: Colors.grey,),
        SizedBox(height: 10),
        CustomButton(
            text: "Continue Shopping",
            onPressed: () {
              mainPageController.changeIndexOfBottomBar(1);
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
      ],
    );
  }
  _notEmptyCart(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppStyle.getDeviceWidthPercent(100, context),
          height: AppStyle.getDeviceHeightPercent(100, context) - 370,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cartController.cart.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(cartController.cart[index].image),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            print(index);
                                              cartController.deleteFromCart(index, context);
                                          },
                                            child: Icon(Icons.close,size: 23,color: Colors.grey,)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(cartController.cart[index].title,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: AppStyle.darkGrey,
                                            fontSize: CommonTextStyle.smallTextStyle,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text((cartController.cart[index].price+cartController.cart[index].additionalPrice).toStringAsFixed(2) +  " " + "AED",
                                              style: TextStyle(
                                                color: AppStyle.productGrey,
                                                fontSize: CommonTextStyle.smallTextStyle,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              width: AppStyle.getDeviceWidthPercent(25, context),
                                              decoration: BoxDecoration(
                                                  color: cartController.cart[index].count>0?AppStyle.primary:Colors.red,
                                                  borderRadius: BorderRadius.circular(30),
                                                  // border: Border.all(color: AppStyle.primary)
                                              ),
                                              child: Center(
                                                child: cartController.cart[index].count>0?Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          Option option = Option(id: cartController.cart[index].productOptionsId, weightId: cartController.cart[index].weightId, sizeId: cartController.cart[index].sizeId, colorId: cartController.cart[index].colorId, productId: cartController.cart[index].productId, additionalPrice: cartController.cart[index].additionalPrice, stock: cartController.cart[index].stouck, weight: cartController.cart[index].weight, size: cartController.cart[index].size, color:cartController.cart[index].color, degree: cartController.cart[index].degree);
                                                          cartController.decrease(option, -1, context);
                                                        },
                                                        child: Icon(Icons.remove,color: Colors.white,size: 18)),
                                                    Text(cartController.cart[index].count.toString(),
                                                      style: TextStyle(
                                                          fontSize: CommonTextStyle.smallTextStyle,
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Option option = Option(id: cartController.cart[index].productOptionsId, weightId: cartController.cart[index].weightId, sizeId: cartController.cart[index].sizeId, colorId: cartController.cart[index].colorId, productId: cartController.cart[index].productId, additionalPrice: cartController.cart[index].additionalPrice, stock: cartController.cart[index].stouck, weight: cartController.cart[index].weight, size: cartController.cart[index].size, color:cartController.cart[index].color, degree: cartController.cart[index].degree);
                                                        cartController.increase(option, 1, context);
                                                      },
                                                      child: Icon(Icons.add,color: Colors.white,size: 18,),
                                                    ),
                                                  ],
                                                ):Text("Out Of Stock",style: TextStyle(color: Colors.white,fontSize: 12),),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Obx(() => cartController.cart[index].loading_op.value?Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(color: AppStyle.primary,),
                    ),
                  ):Center())

                ],
              );
            },
          ),
        ),
        Container(
            width: AppStyle.getDeviceWidthPercent(100, context),
            height: 170,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal",
                        style: TextStyle(
                          color: AppStyle.darkGrey,
                          fontSize: CommonTextStyle.smallTextStyle,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final boxWidth = constraints.constrainWidth();
                            final dashWidth = 4.0;
                            final dashHeight = 2.0;
                            final dashCount =
                            (boxWidth / (2 * dashWidth)).floor();
                            return Flex(
                              children: List.generate(dashCount, (_) {
                                return SizedBox(
                                  width: dashWidth,
                                  height: dashHeight,
                                  child: const DecoratedBox(
                                    decoration:
                                    BoxDecoration(color: AppStyle.darkGrey),
                                  ),
                                );
                              }),
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("AED " + cartController.subTotal.value.toStringAsFixed(2),
                        style: TextStyle(
                          color: AppStyle.darkGrey,
                          fontSize: CommonTextStyle.smallTextStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping Fee",
                        style: TextStyle(
                          color: AppStyle.darkGrey,
                          fontSize: CommonTextStyle.smallTextStyle,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final boxWidth = constraints.constrainWidth();
                            final dashWidth = 4.0;
                            final dashHeight = 2.0;
                            final dashCount =
                            (boxWidth / (2 * dashWidth)).floor();
                            return Flex(
                              children: List.generate(dashCount, (_) {
                                return SizedBox(
                                  width: dashWidth,
                                  height: dashHeight,
                                  child: const DecoratedBox(
                                    decoration:
                                    BoxDecoration(color: AppStyle.darkGrey),
                                  ),
                                );
                              }),
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("AED " + cartController.shipping.value.toStringAsFixed(2),
                        style: TextStyle(
                          color: AppStyle.darkGrey,
                          fontSize: CommonTextStyle.smallTextStyle,
                        ),
                      ),
                    ],
                  ),
                  API.discount>0?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount",
                        style: TextStyle(
                          color: AppStyle.darkGrey,
                          fontSize: CommonTextStyle.smallTextStyle,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final boxWidth = constraints.constrainWidth();
                            final dashWidth = 4.0;
                            final dashHeight = 2.0;
                            final dashCount =
                            (boxWidth / (2 * dashWidth)).floor();
                            return Flex(
                              children: List.generate(dashCount, (_) {
                                return SizedBox(
                                  width: dashWidth,
                                  height: dashHeight,
                                  child: const DecoratedBox(
                                    decoration:
                                    BoxDecoration(color: AppStyle.darkGrey),
                                  ),
                                );
                              }),
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(API.discount.toStringAsFixed(0)+" %",
                        style: TextStyle(
                          color: AppStyle.darkGrey,
                          fontSize: CommonTextStyle.smallTextStyle,
                        ),
                      ),
                    ],
                  ):Center(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cart Total",
                        style: TextStyle(
                          color: AppStyle.darkGrey,
                          fontSize: CommonTextStyle.mediumTextStyle,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final boxWidth = constraints.constrainWidth();
                            final dashWidth = 4.0;
                            final dashHeight = 2.0;
                            final dashCount =
                            (boxWidth / (2 * dashWidth)).floor();
                            return Flex(
                              children: List.generate(dashCount, (_) {
                                return SizedBox(
                                  width: dashWidth,
                                  height: dashHeight,
                                  child: const DecoratedBox(
                                    decoration:
                                    BoxDecoration(color: AppStyle.darkGrey),
                                  ),
                                );
                              }),
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("AED " + cartController.total.value.toStringAsFixed(2),
                        style: TextStyle(
                          color: AppStyle.primary,
                          fontSize: CommonTextStyle.mediumTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  CustomButton(
                      text: "CHECKOUT",
                      onPressed: () {
                        Get.to(() => Checkout());
                      },
                      color: AppStyle.primary,
                      borderRadius: 30,
                      border: Colors.transparent,
                      width: AppStyle.getDeviceWidthPercent(57, context),
                      height: AppStyle.getDeviceHeightPercent(6, context),
                      textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
                  ),
                  SizedBox(height: Get.bottomBarHeight,)
                ],
              ),
            )
        ),
      ],
    );
  }


}