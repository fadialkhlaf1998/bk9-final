import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/customer_order_controller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/model/customer_order.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:bk9/view/order_items.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerOrderView extends StatelessWidget {

  // CustomerOrderView(List<CustomerOrder> orders) {
  //   customerOrderController.orders = orders;
  // }
  RxBool loading = false.obs;
  RxBool inStoreSelected = false.obs;
  CustomerOrderView(int id) {
    loading.value = true;
    API.checkInternet().then((internet) async {
      if (internet) {
        API.getCustomerOrders(API.customer_id).then((value) {
          loading.value = false;
          if(value!=null){
            customerOrderController.orders = value.customerOrder!;
            customerOrderController.inStore = value.inStoreOrder!;
          }


        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          Get.off(() => CustomerOrderView(id));
        });
      }
    }).catchError((err) {
      loading.value = false;
      err.printError();
    });
  }

  CustomerOrderController customerOrderController = Get.put(CustomerOrderController());
  MainPageController mainPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              loading.value ?
              Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _header(context),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                              // color: Colors.white.withOpacity(0.5),
                              child: Center(
                                child: CircularProgressIndicator(color: AppStyle.primary,),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ) :  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    _selecter(context),
                    SizedBox(height: 15),
                    inStoreSelected.value
                    ?_inStoreOrder(context)
                        :_order(context),

                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: _header(context),
              )
            ],
          ),
        )
    ));
  }
  _selecter(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              inStoreSelected.value = false;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Online Orders",
                  style: TextStyle(
                      color: !inStoreSelected.value ?
                      AppStyle.primary:AppStyle.grey,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 2),
                Container(height: 2,width: 120,color: !inStoreSelected.value ?AppStyle.primary:AppStyle.grey,)
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              inStoreSelected.value = true;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("In-Store Orders",
                  style: TextStyle(
                      color: inStoreSelected.value ?
                      AppStyle.primary:AppStyle.grey,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 2),
                Container(height: 2,width: 120,color: inStoreSelected.value ?AppStyle.primary:AppStyle.grey,)
              ],
            ),
          ),
        ],
      ),
    );
  }
  _inStoreOrder(BuildContext context){
    return Column(
      children: [
        customerOrderController.inStore.isEmpty ?
        Column(
          children: [
            TextApp(text: "You don't have any orders yet",
                width: AppStyle.getDeviceWidthPercent(80, context),
                height: AppStyle.getDeviceHeightPercent(8, context),
                textStyle: CommonTextStyle.textStyleForDarkGreySmallButtonBold
            ),
            SizedBox(height: 10),
            CustomButton(
                text: "Continue Shopping",
                onPressed: () {
                  Get.back();
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
        ) :
        Container(
            child: ListView.builder(
                itemCount: customerOrderController.inStore.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return items(context, customerOrderController.inStore[index]);
                })),
        SizedBox(height: 20,)
      ],
    );
  }
  _order(BuildContext context){
    return Column(
      children: [
        customerOrderController.orders.isEmpty ?
        Column(
          children: [
            TextApp(text: "You don't have any orders yet",
                width: AppStyle.getDeviceWidthPercent(80, context),
                height: AppStyle.getDeviceHeightPercent(8, context),
                textStyle: CommonTextStyle.textStyleForDarkGreySmallButtonBold
            ),
            SizedBox(height: 10),
            CustomButton(
                text: "Continue Shopping",
                onPressed: () {
                  Get.back();
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
        ) :
        Container(
            child: ListView.builder(
                itemCount: customerOrderController.orders.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return items(context, customerOrderController.orders[index]);
                })),
        SizedBox(height: 20,)
      ],
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
                child: Text("Order History",
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
  items(BuildContext context, CustomerOrder orderItem) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppStyle.getDeviceWidthPercent(90, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Order ID" + ": ",
                            style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                          ),
                          Text(orderItem.orderNumber,
                            style: CommonTextStyle.textStyleForWhiteSmallButtonNormal
                          )
                        ],
                      ),
                      Text(
                        _date_covert(orderItem.createdAt),
                        style: CommonTextStyle.textStyleForGreyTinyButton
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "phone" + ": ",
                        style: CommonTextStyle.textStyleForDarkGreySmallButtonBold
                      ),
                      Text(
                        orderItem.phone,
                        style:  CommonTextStyle.textStyleForGreySmallButton,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "total" + ": ",
                              style: CommonTextStyle.textStyleForDarkGreySmallButtonBold
                          ),
                          Text(
                            orderItem.total.toStringAsFixed(2),
                            style: CommonTextStyle.textStyleForGreySmallButton,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "subTotal" + ": ",
                              style: CommonTextStyle.textStyleForDarkGreySmallButtonBold
                          ),
                          Text(
                            orderItem.subTotal.toStringAsFixed(2),
                            style: CommonTextStyle.textStyleForGreySmallButton,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "discount" + ": ",
                              style: CommonTextStyle.textStyleForDarkGreySmallButtonBold
                          ),
                          Text(
                            orderItem.discount.toStringAsFixed(2),
                            style: CommonTextStyle.textStyleForGreySmallButton,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "shipping" + ": ",
                              style: CommonTextStyle.textStyleForDarkGreySmallButtonBold
                          ),
                          Text(
                            orderItem.shipping.toStringAsFixed(2),
                            style: CommonTextStyle.textStyleForGreySmallButton,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  state(orderItem.orderState, context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          text: "view order",
                          onPressed: () {
                            // customerOrderController.viewOrder(orderItem.id, context);
                            Get.to(() => OrderItems(orderItem.id));
                          },
                          color: AppStyle.primary,
                          borderRadius: 20,
                          border: AppStyle.primary,
                          width: 100,
                          height: 30,
                          textStyle: CommonTextStyle.textStyleForOrangeMediumButton
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _date_covert(DateTime dateTime) {
    final format = DateFormat('MMM-dd-yyyy');
    final clockString = format.format(dateTime);
    return clockString.replaceAll(" ", ",");
  }
  state(int state, BuildContext context) {
    if (state == -1) {
      return Row(
        children: const [
          Text("canceled",
            style: TextStyle(
              color: Colors.red,
              fontSize: CommonTextStyle.tinyTextStyle
            )
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.close,
            color: AppStyle.grey,
            size: CommonTextStyle.tinyTextStyle,
          ),
        ],
      );
    } else if (state == 0) {
      return Row(
        children: const [
          Text("pending",
              style: TextStyle(
                  color: AppStyle.primary,
                  fontSize: CommonTextStyle.tinyTextStyle
              )
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.history,
            color: AppStyle.grey,
            size: CommonTextStyle.tinyTextStyle,
          ),
        ],
      );
    } else if(state == 1){
      return Row(
        children: const [
          Text("delivered",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: CommonTextStyle.tinyTextStyle
              )
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.check_circle,
            color: AppStyle.grey,
            size: CommonTextStyle.tinyTextStyle,
          ),
        ],
      );
    }else {
      return Row(
        children: const [
          Text("In Store Order",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: CommonTextStyle.tinyTextStyle
              )
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.check_circle,
            color: AppStyle.grey,
            size: CommonTextStyle.tinyTextStyle,
          ),
        ],
      );
    }
  }

}