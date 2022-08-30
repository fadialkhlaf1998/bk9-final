import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/model/customer_order.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:bk9/view/order_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderController extends GetxController {
  var loading = false.obs;
  List<CustomerOrder> orders = <CustomerOrder>[];
  List<CustomerOrder> inStore = <CustomerOrder>[];

  // viewOrder(int orderId, BuildContext context) {
  //   API.checkInternet().then((internet) async {
  //     if (internet) {
  //       loading.value = true;
  //       API.orderItems(orderId).then((posts) {
  //         if (posts.isNotEmpty) {
  //           loading.value = false;
  //           Get.to(() => OrderItems(posts));
  //         } else {
  //           AppStyle.errorMsg(context, "something went wrong");
  //         }
  //       });
  //     } else {
  //       Get.to(() => NoInternet());
  //     }
  //   }).catchError((err) {
  //     loading.value = false;
  //     err.printError();
  //   });
  // }

}
