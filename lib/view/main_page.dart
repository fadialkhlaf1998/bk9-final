import 'package:bk9/controller/main_class_controller.dart';
import 'package:bk9/view/Account.dart';
import 'package:bk9/view/cart.dart';
import 'package:bk9/view/services.dart';
import 'package:bk9/view/shop.dart';
import 'package:bk9/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {

  MainClassController mainClassController = Get.put(MainClassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: PageView(
          controller: mainClassController.pageController,
          onPageChanged: (index){
            //mainClassController.selectedIndex.value = index;
          },
          physics: NeverScrollableScrollPhysics(),
          children: [
            Home(),
            Shop(),
            Services(),
            Cart(),
            Account()
          ],
        ),
      ),
    );
  }
}
