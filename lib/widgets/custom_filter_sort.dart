import 'package:bk9/const/app-style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class CustomFilterSort extends StatelessWidget {

  const CustomFilterSort();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      color: AppStyle.primary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              ///filter page
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                color: Colors.transparent,
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/filter.svg",width: 25,height: 25,color: Colors.white,),
                    SizedBox(width: 20),
                    Text("Filter by",
                        style: CommonTextStyle.textStyleForOrangeMediumButton
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            child: const VerticalDivider(
              color: Colors.white,
              thickness: 1,
              indent: 30,
              endIndent: 5,
              width: 20,
            ),
          ),
          GestureDetector(
            onTap: () {
              sortBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 150,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/sort.svg",width: 25,height: 25,color: Colors.white,),
                    SizedBox(width: 20),
                    Text("Sort by",
                        style: CommonTextStyle.textStyleForOrangeMediumButton
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  sortBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
          ),
      ),
      builder: (context) {
        return Container(
          height: AppStyle.getDeviceHeightPercent(44, context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Container(
                  width: AppStyle.getDeviceWidthPercent(78, context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sort By",
                        style: TextStyle(
                          color: AppStyle.grey,
                          fontSize: CommonTextStyle.smallTextStyle,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close,color: AppStyle.grey,size: 20,),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height: AppStyle.getDeviceHeightPercent(5, context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppStyle.greyButton,
                        onPrimary: AppStyle.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppStyle.grey)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Center(
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppStyle.primary,
                                      border: Border.all(color: AppStyle.grey)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text("Recommended"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height: AppStyle.getDeviceHeightPercent(5, context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppStyle.greyButton,
                        onPrimary: AppStyle.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppStyle.grey)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Center(
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppStyle.primary,
                                      border: Border.all(color: AppStyle.grey)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text("Newest First"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height: AppStyle.getDeviceHeightPercent(5, context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppStyle.greyButton,
                        onPrimary: AppStyle.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppStyle.grey)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Center(
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppStyle.primary,
                                      border: Border.all(color: AppStyle.grey)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text("Top Rated"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height: AppStyle.getDeviceHeightPercent(5, context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppStyle.greyButton,
                        onPrimary: AppStyle.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppStyle.grey)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Center(
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppStyle.primary,
                                      border: Border.all(color: AppStyle.grey)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text("Lowest Price"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    height: AppStyle.getDeviceHeightPercent(5, context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppStyle.greyButton,
                        onPrimary: AppStyle.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppStyle.grey)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Center(
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppStyle.primary,
                                      border: Border.all(color: AppStyle.grey)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text("Highest Price"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}