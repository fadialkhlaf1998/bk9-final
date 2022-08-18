import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/view/services_details.dart';
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
        // _posts(context),
        _selecter(context),
        selected_viewer.value == 0 ?
        _eventsList(context) : _blogsList(context)
      ],
    );
  }
  _selecter(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
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
                Text("Events",style: TextStyle(color: selected_viewer.value == 0 ?AppStyle.primary:Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
                Container(height: 2,width: 50,color: selected_viewer.value == 0 ?AppStyle.primary:Colors.grey,)
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
                Text("Blogs",style: TextStyle(color: selected_viewer.value == 1 ?AppStyle.primary:Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
                Container(height: 2,width: 50,color: selected_viewer.value == 1 ?AppStyle.primary:Colors.grey,)
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
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 5/7,
          crossAxisCount: 2,
        ),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: blogs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(3,1)
                  )
                ]
            ),
            child: GestureDetector(

              onTap: () {

              },
              child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Expanded(flex: 5,child: Container(
                        // width: width,
                        // height: height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                            image: DecorationImage(
                                image: NetworkImage(blogs[index].image!),
                                fit: BoxFit.cover
                            )
                        ),
                      ),),
                      Expanded(flex: 2,child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(blogs[index].title!,textAlign: TextAlign.center,)
                          ],
                        ),
                      )),

                    ],
                  )
              ),
            ),
          );
        });
  }

  _eventsList(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 5/7,
          crossAxisCount: 2,
        ),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: events.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(3,1)
                )
              ]
            ),
            child: GestureDetector(

              onTap: () {

              },
              child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Expanded(flex: 5,child: Container(
                        // width: width,
                        // height: height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                            image: DecorationImage(
                                image: NetworkImage(events[index].image!),
                                fit: BoxFit.cover
                            )
                        ),
                      ),),
                      Expanded(flex: 2,child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(events[index].title!,textAlign: TextAlign.center,)
                          ],
                        ),
                      )),

                    ],
                  )
              ),
            ),
          );
        });
  }



}
