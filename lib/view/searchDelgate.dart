import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SearchTextField extends SearchDelegate<String> {
  String? result;
  IntroController introController;

  SearchTextField({required this.introController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
     Padding(
       padding: EdgeInsets.symmetric(horizontal: 15),
       child: Row(
         children: [
           GestureDetector(
             onTap: () {
               introController.search(context, query);
             },
               child: Text("Search",
                 style: TextStyle(
                     color: AppStyle.primary,
                   fontSize: CommonTextStyle.mediumTextStyle
                 ),))
         ],
       ),
     )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,size: 23,color: AppStyle.darkGrey,),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white, //new AppBar color
        elevation: 0,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppStyle.darkGrey,
      ),
      hintColor: AppStyle.darkGrey,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: CommonTextStyle.mediumTextStyle,
          color: AppStyle.darkGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = introController.searchSugg.where((elm) {
      return elm.title.toLowerCase().contains(query.toLowerCase());
    });
    return Stack(
      children: [
        Container(
            height: AppStyle.getDeviceHeightPercent(100, context),
            width: AppStyle.getDeviceWidthPercent(100, context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Background.png"),
                    fit: BoxFit.cover
                )
            ),
            child: introController.search(context, query)
        ),
        introController.loading.value ?
        Positioned(child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white.withOpacity(0.5),
          child: Center(
            child: CircularProgressIndicator(color: AppStyle.primary,),
          ),
        )) : Center()
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = introController.searchSugg.where((elm) {
      return elm.title.toLowerCase().contains(query.toLowerCase());
    });
    return suggestions.isEmpty ?
        Container(
          height: AppStyle.getDeviceHeightPercent(100, context),
          width: AppStyle.getDeviceWidthPercent(100, context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Background.png"),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No results matched",
                style: CommonTextStyle.textStyleForDarkGreyMediumButton,
              )
            ],
          )
        ) :
      Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Background.png"),
              fit: BoxFit.cover
          )
      ),
      child:Obx(() => introController.loadingSearch.value?Center(child: CircularProgressIndicator(color: AppStyle.primary,),): ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    query = suggestions.elementAt(index).title;
                    // introController.search(context, query);
                  },
                  onDoubleTap: () {
                    ///go to service page ore service
                    introController.search(context, query);
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(suggestions.elementAt(index).title,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: CommonTextStyle.smallTextStyle,
                                      color: AppStyle.darkGrey,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Divider(
                              color: AppStyle.grey.withOpacity(0.3),
                              thickness: 0.5,
                            ),
                          )
                        ],
                      )
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}