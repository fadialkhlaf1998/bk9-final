import 'package:bk9/const/app-style.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';

class CustomGridViewServices extends StatelessWidget {

  final int count;
  final double childAspectRatio;
  final List<Object> myList;
  final VoidCallback onTap;


  const CustomGridViewServices({
    required this.count,
    required this.childAspectRatio,
    required this.myList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: childAspectRatio
        ),
        scrollDirection: Axis.vertical,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          // width: AppStyle.getDeviceWidthPercent(100, context),
                          // height: AppStyle.getDeviceHeightPercent(100, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)
                            ),
                            image: DecorationImage(
                                image: AssetImage("assets/images/DayCare.png")
                            ),
                          ),
                        child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text("Day Care",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: CommonTextStyle.smallTextStyle
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
          );
        });
  }
}
