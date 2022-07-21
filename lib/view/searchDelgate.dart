// import 'package:bk9/const/app-style.dart';
// import 'package:bk9/controller/intro_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// class SearchTextField extends SearchDelegate<String> {
//   String? result;
//   IntroController introController;
//
//   SearchTextField({required this.introController});
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       query.isEmpty ?
//       Visibility(
//         child: Text(''),
//         visible: false,) :
//       IconButton(
//         icon: Icon(Icons.close, color: Colors.black),
//         onPressed: () {
//           query="";
//         },
//       )
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back,size: 30),
//       onPressed: () {
//         Get.back();
//       },
//     );
//   }
//
//
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return super.appBarTheme(context).copyWith(
//       appBarTheme: AppBarTheme(
//         color: AppStyle.primary, //new AppBar color
//         elevation: 0,
//       ),
//       textSelectionTheme: TextSelectionThemeData(
//         cursorColor: Colors.black,
//       ),
//       hintColor: Colors.black,
//       textTheme: TextTheme(
//         headline6: TextStyle(
//             color: Colors.black,
//             fontSize: 18
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     final suggestions = introController.product.where((elm) {
//       return elm.title!.toLowerCase().contains(query.toLowerCase());
//     });
//     return Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: AppStyle.grey,
//         child: Center(
//           child: Text("no_result_matched",
//           style: TextStyle(
//             fontSize: CommonTextStyle.smallTextStyle,
//             fontWeight: FontWeight.bold,
//             color: AppStyle.grey)
//           ),
//         )
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = introController.product.where((elm) {
//       return elm.title!.toLowerCase().contains(query.toLowerCase());
//     });
//     return Container(
//       // color: AppColors.secondaryColor,
//       child: ListView.builder(
//         itemCount: suggestions.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.only(left: 10,right: 10),
//             child: Column(
//               children: [
//                 SizedBox(height: 10,),
//                 GestureDetector(
//                   onTap: () {
//                     // homeController.goToProductPage(suggestions.elementAt(index));
//                   },
//                   child: Container(
//                     height: 50,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                                 image: DecorationImage(
//                                     image: NetworkImage( suggestions.elementAt(index).image == null ?
//                                     "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png" :
//                                     suggestions.elementAt(index).image!),
//                                     fit: BoxFit.cover
//                                 )
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10,right: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Text(suggestions.elementAt(index).title!,
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                       overflow: TextOverflow.ellipsis
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(suggestions.elementAt(index).title!,
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black54,
//                                         overflow: TextOverflow.ellipsis
//                                     ),
//                                   ),
//                                 ),
//                                 // Expanded(
//                                 //   child:  AppWidget.appText(suggestions.elementAt(index).variants!.first.price! +
//                                 //        " "+ App_Localization.of(context).translate("AED"),
//                                 //       Colors.black, 14, FontWeight.bold),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }