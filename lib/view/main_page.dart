import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/view/Account.dart';
import 'package:bk9/view/cart.dart';
import 'package:bk9/view/services.dart';
import 'package:bk9/view/shop.dart';
import 'package:bk9/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {

  MainPageController mainPageController = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        bottomNavigationBar: _bottomBar(context),
        body: SafeArea(
          child: PageView(
            controller: mainPageController.pageController,
            onPageChanged: (index){
              mainPageController.selectedIndex.value = index;
            },
            children: [ Home(), Shop(), Services(), Cart(), Account() ],
          ),
        ),
      );
    });
  }

  _bottomBar(context){
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: 55,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Row(
        children: [
          buttonForBottomBar(context,0),
          buttonForBottomBar(context,1),
          buttonForBottomBar(context,2),
          buttonForBottomBar(context,3),
          buttonForBottomBar(context,4),
        ],
      ),
    );
  }

  buttonForBottomBar(context,index){
    return GestureDetector(
      onTap: (){
        mainPageController.changeIndexOfBottomBar(index);
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: AppStyle.getDeviceWidthPercent(20, context),
          height: 55,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide( width: mainPageController.selectedIndex.value == index ? 3 : 0,
                      color: mainPageController.selectedIndex.value == index ? AppStyle.primary : Colors.transparent
                  )
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                width: AppStyle.getDeviceWidthPercent(18, context),
                // height: AppStyle.getDeviceHeightPercent(3, context),
                //todo new update
                height: 30,
                child: SvgPicture.asset(
                  'assets/icons/${mainPageController.iconList[index]}.svg',
                  fit: BoxFit.contain,
                  color: mainPageController.selectedIndex.value == index
                      ? AppStyle.primary
                      : AppStyle.grey,
                ),
              ),
              Text(
                  mainPageController.iconList[index],
                  style: mainPageController.selectedIndex.value == index
                      ? CommonTextStyle.textStyleForSelectBottomBar
                      : CommonTextStyle.textStyleForBottomBar
              )
            ],
          )
      ),
    );
  }

}
