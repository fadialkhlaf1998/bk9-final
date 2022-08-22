import 'package:bk9/const/app-style.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsBlogs extends StatelessWidget {

  // IntroController introController = Get.find();
  List<Post> events = <Post>[];
  List<Post> blogs = <Post>[];
  var selected_viewer = 0.obs;

  EventsBlogs(this.events, this.blogs);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _header(context),
                    const SizedBox(height: 10),
                    _body(context),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        )
    ));
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
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,size: 23,)
              ),
              SizedBox(width: 25),
              Container(
                width: AppStyle.getDeviceWidthPercent(45, context),
                child: Text("Events And Bolgs",
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
  _body(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 20,),
        _selecter(context),
        selected_viewer.value == 0 ?
        _eventsList(context) : _blogsList(context)
      ],
    );
  }
  _selecter(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              selected_viewer.value = 0;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Events",
                  style: TextStyle(
                      color: selected_viewer.value == 0 ?
                      AppStyle.primary:AppStyle.grey,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 2),
                Container(height: 2,width: 70,color: selected_viewer.value == 0 ?AppStyle.primary:AppStyle.grey,)
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              selected_viewer.value = 1;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Blogs",
                  style: TextStyle(
                      color: selected_viewer.value == 1 ?
                      AppStyle.primary:AppStyle.grey,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 2),
                Container(height: 2,width: 70,color: selected_viewer.value == 1 ?AppStyle.primary:AppStyle.grey,)
              ],
            ),
          )
        ],
      ),
    );
  }
  _blogsList(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5
        ),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: blogs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: AppStyle.getDeviceWidthPercent(90, context),
            height: AppStyle.getDeviceHeightPercent(25, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: AppStyle.getDeviceWidthPercent(90, context),
                    height: AppStyle.getDeviceHeightPercent(18, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(blogs[index].image!),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppStyle.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blogs[index].title!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              blogs[index].subTitle!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        });
  }
  _eventsList(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5
        ),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: events.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: AppStyle.getDeviceWidthPercent(90, context),
            height: AppStyle.getDeviceHeightPercent(25, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: AppStyle.getDeviceWidthPercent(90, context),
                    height: AppStyle.getDeviceHeightPercent(18, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(events[index].image!),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppStyle.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events[index].title!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              events[index].subTitle!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        });
  }
}
