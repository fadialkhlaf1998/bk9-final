import 'package:bk9/const/app-style.dart';
import 'package:bk9/model/order_items.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderItems extends StatelessWidget {

  List<OrderItem> orderItem;
  OrderItems(this.orderItem);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Container(
                        child: ListView.builder(
                            itemCount: orderItem.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return items(context,orderItem[index]);
                            })),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        )
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
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,size: 23,)
              ),
              SizedBox(width: 25),
              Container(
                width: AppStyle.getDeviceWidthPercent(45, context),
                child: Text("My Order",
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
  items(BuildContext context,OrderItem orderItem) {
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
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: AppStyle.getDeviceHeightPercent(12, context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(orderItem.image),
                            fit: BoxFit.cover
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(orderItem.title,
                            maxLines: 2,
                            style: TextStyle(
                                color: AppStyle.darkGrey,
                                fontSize: CommonTextStyle.smallTextStyle,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("count" + ": ",
                                    style: CommonTextStyle.textStyleForDarkGreySmallButtonBold,
                                  ),
                                  Text(orderItem.count.toString(),
                                    style: CommonTextStyle.textStyleForGreySmallButton,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("total" + ": ",
                                    style: CommonTextStyle.textStyleForDarkGreySmallButtonBold,
                                  ),
                                  Text(
                                    orderItem.price.toString() + " " + "AED",
                                    style: CommonTextStyle.textStyleForWhiteSmallButton,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("size" + ": ",
                                    style: CommonTextStyle.textStyleForDarkGreySmallButtonBold,
                                  ),
                                  Text(
                                    orderItem.size.toString(),
                                    style: CommonTextStyle.textStyleForWhiteSmallButton,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("weight" + ": ",
                                    style: CommonTextStyle.textStyleForDarkGreySmallButtonBold,
                                  ),
                                  Text(
                                    orderItem.weight.toString(),
                                    style: CommonTextStyle.textStyleForWhiteSmallButton,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("color" + ": ",
                                style: CommonTextStyle.textStyleForDarkGreySmallButtonBold,
                              ),
                              Text(
                                orderItem.color.toString(),
                                style: CommonTextStyle.textStyleForWhiteSmallButton,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}