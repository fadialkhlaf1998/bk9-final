import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/account_controller.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/controller/checkout_controller.dart';
import 'package:bk9/view/create_address.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/shipping_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key}) : super(key: key);

  CheckoutController checkoutController = Get.put(CheckoutController());
  AddressesController addressesController = Get.find();
  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    _body(context),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: _header(context),
              ),
              checkoutController.loading.value?
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

  _header(BuildContext context) {
    return Container(
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
              Container(
                width: AppStyle.getDeviceWidthPercent(45, context),
                child: Text("Checkout",
                    style: TextStyle(
                      fontSize: CommonTextStyle.mediumTextStyle,
                      color: AppStyle.darkGrey,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ],
          ),
          checkoutController.selected.value == 1 ?
          GestureDetector(
            onTap: () {
              Get.to(() => CreateAddress(-1, 0,
                addressesController.nickName.text,
                addressesController.defaultAddress.value,
                addressesController.adddress1.text,
                addressesController.adddress2.text,
                addressesController.apartment.text,
                addressesController.phone.text,
                addressesController.emirate.value,
                addressesController.country.value,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 40,
                height: 70,
                decoration: BoxDecoration(
                  color: AppStyle.primary,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.add,color: Colors.white),
              ),
            ),
          )
          :
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: GestureDetector(
                onTap: () {
                  ///wishlist page
                },
                child: ContainerWithImage(
                    width: 40,
                    height: 70,
                    image: "assets/icons/wishlist.svg",
                    color: Colors.transparent,
                    option: 0)
            ),
          )
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        checkoutController.selected.value == 0 ?
            _shippingPaymentMethod(context) : checkoutController.selected.value == 1 ?
        _addressesList(context) : Center() ,
        SizedBox(height: 50),
        _nextBackButtons(context),

      ],
    );
  }
  _shippingPaymentMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text("Shipping Method",
            style: CommonTextStyle.textStyleForDarkGreyMediumButton,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: ShippingMethod(
            onTap: () {
              checkoutController.shippingMethod.value = 0 ;
            },
            color: checkoutController.shippingMethod.value == 0 ? Colors.white : Colors.transparent,
            boxShadow: BoxShadow(
              color: checkoutController.shippingMethod.value == 0 ?
              Colors.grey.withOpacity(0.3) : Colors.transparent,
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(1,3),
            ),
            child1: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppStyle.grey),
                  ),
                  child: Center(
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: checkoutController.shippingMethod.value == 0 ? AppStyle.primary : Colors.white,
                        ),
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Text("Home Delivery",
                  style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                )
              ],
            ),
            child2: Container(),
            child3: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 10,),
                Container(
                  width: AppStyle.getDeviceWidthPercent(65, context),
                  child: Text("Your items will be delivered to your door step. Additionalfee will be applied.",
                    style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ShippingMethod(
            onTap: () {
              checkoutController.shippingMethod.value = 2;
            },
            color: checkoutController.shippingMethod.value != 0 ? Colors.white : Colors.transparent,
            boxShadow: BoxShadow(
              color: checkoutController.shippingMethod.value != 0 ?
              Colors.grey.withOpacity(0.3) : Colors.transparent,
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(1,3),
            ),
            child1: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppStyle.grey),
                  ),
                  child: Center(
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: checkoutController.shippingMethod.value !=0 ?AppStyle.primary : Colors.transparent,
                        ),
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Text("In-Store Pick Up",
                  style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                )
              ],
            ),
            child2: Container(),
            child3: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 10,),
                Container(
                  width: AppStyle.getDeviceWidthPercent(65, context),
                  child: Text("Save on delivery cost. You will receive an SMS when yourorder is ready for collection.",
                    style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: AppStyle.getDeviceWidthPercent(90, context),
          alignment: Alignment.center,
          child:Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints constraints) {
                    final boxWidth = constraints.constrainWidth();
                    final dashWidth = 2.0;
                    final dashHeight = 1.0;
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
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text("Payment Method",
            style: CommonTextStyle.textStyleForDarkGreyMediumButton,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ShippingMethod(
              onTap: () {
                checkoutController.paymentMethod.value = 0 ;
              },
              color: checkoutController.paymentMethod.value == 0 ? Colors.white : Colors.transparent,
              boxShadow: BoxShadow(
                color: checkoutController.paymentMethod.value == 0 ?
                Colors.grey.withOpacity(0.3) : Colors.transparent,
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(1,3),
              ),
              child1: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppStyle.grey),
                    ),
                    child: Center(
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: checkoutController.paymentMethod.value == 0 ? AppStyle.primary : Colors.white,
                          ),
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("Cash / Card on Delivery",
                    style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                  )
                ],
              ),
              child2: Container(),
              child3: Container()
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ShippingMethod(
            onTap: () {
              checkoutController.paymentMethod.value = 1;
            },
            color: checkoutController.paymentMethod.value != 0 ? Colors.white : Colors.transparent,
            boxShadow: BoxShadow(
              color: checkoutController.paymentMethod.value != 0 ?
              Colors.grey.withOpacity(0.3) : Colors.transparent,
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(1,3),
            ),
            child1: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppStyle.grey),
                  ),
                  child: Center(
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: checkoutController.paymentMethod.value !=0 ?AppStyle.primary : Colors.transparent,
                        ),
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Text("Credit / Debit Card",
                  style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                )
              ],
            ),
            child2: Container(),
            child3: Container(),
          ),
        ),
      ],
    );
  }
  _addressesList(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: AppStyle.getDeviceWidthPercent(100, context),
            height: AppStyle.getDeviceHeightPercent(60, context),
            child:  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: addressesController.addresses.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: () {
                    checkoutController.selectAddress.value = index;
                  },
                  child: Container(
                      width: AppStyle.getDeviceWidthPercent(85, context),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:  Colors.grey.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(1,3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Obx(() => Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppStyle.grey),
                                      ),
                                      child: Center(
                                          child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: checkoutController.selectAddress.value == index ?
                                              AppStyle.primary
                                                  : Colors.white,
                                            ),
                                          )
                                      ),
                                    ),),
                                    SizedBox(width: 10,),
                                    Text(addressesController.addresses[index].firstName.toUpperCase(),
                                      style: CommonTextStyle.textStyleForWhiteMediumButton,
                                    ),
                                  ],
                                ),
                                CustomButton(
                                    text: "Default Address",
                                    onPressed: () {
                                      if(addressesController.addresses[index].isDefault == 1) {
                                        print(addressesController.addresses[index].isDefault);
                                      }
                                      else {
                                        addressesController.setDefault(addressesController.addresses[index]);
                                      }
                                    },
                                    color: addressesController.addresses[index].isDefault == 1 ?
                                    AppStyle.primary : Colors.grey.withOpacity(0.5),
                                    borderRadius: 30,
                                    border: addressesController.addresses[index].isDefault == 1 ?
                                    AppStyle.primary : Colors.grey.withOpacity(0.5),
                                    width: 100,
                                    height: 30,
                                    textStyle: CommonTextStyle.textStyleForOrangeBigButton
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(addressesController.addresses[index].address1,
                                  style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(addressesController.addresses[index].address2,
                                  style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(addressesController.addresses[index].country,
                                  style: CommonTextStyle.textStyleForGreySmallButton,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(
                              width: AppStyle.getDeviceWidthPercent(70, context),
                              child: Row(
                                children: [
                                  Text(addressesController.addresses[index].apartment + "  " + addressesController.addresses[index].state,
                                    style: CommonTextStyle.textStyleForGreySmallButton,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(addressesController.addresses[index].phone,
                                  style: CommonTextStyle.textStyleForGreySmallButton,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          addressesController.selectEdit.value = 1;
                                          Get.to(() => CreateAddress(
                                            addressesController.addresses[index].id,
                                            1,
                                            addressesController.addresses[index].firstName,
                                            addressesController.addresses[index].isDefault,
                                            addressesController.addresses[index].address1,
                                            addressesController.addresses[index].address2,
                                            addressesController.addresses[index].apartment,
                                            addressesController.addresses[index].phone,
                                            addressesController.addresses[index].country,
                                            addressesController.addresses[index].state,
                                          ));
                                        },
                                        child: Icon(Icons.edit,color: AppStyle.primary)),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                        onTap: () {
                                          addressesController.deleteAddress(context, addressesController.addresses[index]);
                                        },
                                        child: Icon(Icons.delete,color: Colors.red,))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  _nextBackButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
              text: "Back",
              onPressed: () {
                checkoutController.back();
              },
              color: AppStyle.greyButton,
              borderRadius: 30,
              border: Colors.transparent,
              width: AppStyle.getDeviceWidthPercent(35, context),
              height: AppStyle.getDeviceHeightPercent(6, context),
              textStyle: CommonTextStyle.textStyleForDarkGreyMediumButton
          ),
          CustomButton(
              text: "Next",
              onPressed: () {
                checkoutController.next(context);
              },
              color: AppStyle.primary,
              borderRadius: 30,
              border: Colors.transparent,
              width: AppStyle.getDeviceWidthPercent(35, context),
              height: AppStyle.getDeviceHeightPercent(6, context),
              textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
          ),
        ],
      ),
    );
  }

}