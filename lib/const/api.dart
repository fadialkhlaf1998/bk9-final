import 'dart:convert';
import 'package:bk9/model/post.dart';
import 'package:http/http.dart' as http;



class API {
  static String url = "https://phpstack-548447-2508399.cloudwaysapps.com";

  static String media_url = url + "/uploads/";
  static List<int> main_parents = [26];
  static int product = 27;

  static double discount = 0;
  static int customer_id = -1;
  static String company_id = "";
  static String email = "";
  static String password = "";
  static bool is_active = false;
  static String cookie = "";

  static String public_key = "6Md5Hi31ooTfpzJOUP76fVTM8DPsD5Zcq6v9TFsIxrlCnvf7sG";

  static Future<List<Post>> getServices() async {
    var headers = {
      'api-key': '7126dcfd5f2fdf83c0bca1b0b647f424172a78d818ad1508f0b78748378dfb914a9fc8cede2f525bab9f50ea02add1b030552f135c24fba09a4afa27182827c23e2c2b15cb676cf112e7280e4e97f82aa25853b1f05d4e9ba702625957eec1c93901',
      'locale': 'en',
      'Cookie': 'xJvmAsbjygawycpsadfdfdg57m8a=s%3Ak-k2vDGlC5qkPdNOfkbWQL6rfOFgKsmR.39QUREHQ6CZB1jiLte0jcEKFUS2csb4Ta0UGDQTkre8'
    };
    var request = http.Request('GET', Uri.parse('https://phpstack-548447-2508399.cloudwaysapps.com/api/services'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      //print(data);
      // List<Post> postList = <Post>[];
      var data1 = json.decode(data);
      print('=======================');
      print( data1["data"]["services"]["posts"]);
      print('=======================');
      return ServicesData.fromJson(json.decode(data)).bigData.services.posts;
    }
    else {
      print(response.reasonPhrase);
      return <Post>[];
    }

  }


}
