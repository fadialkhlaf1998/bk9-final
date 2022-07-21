import 'package:bk9/const/api.dart';
import 'package:bk9/model/login_info.dart';
import 'package:bk9/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Store {

  static bool introScreenValue = false;
  static String languageCode = "en";
  static final storage = FlutterSecureStorage();

  /// introduction screen
  static saveIntroScreen(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("value", value);
  }
  static Future loadIntroScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool stringValue = prefs.getBool("value") ?? false;
    return stringValue;
  }

  /// login info
  static saveLogInInfo(String email, String password, String customerId) async{
    LogInInfo loginInfo = LogInInfo(email: email, password: password, id: customerId);
    storage.write(key: "loginInfo", value:loginInfo.toJson());
  }
  static Future<LogInInfo?> loadLogInInfo() async {
    try{
      String loaded = await storage.read(key: "loginInfo")??"non";
      LogInInfo? loginInfo = loaded == "non"
          ? null
          : LogInInfo.fromJson(loaded);
      if (loginInfo != null) {
        API.email = loginInfo.email;
        API.password = loginInfo.password;
        API.customer_id = int.parse(loginInfo.id);
      }
      return loginInfo;
    }catch(e){
      return null;
    }

  }

  /// active
  static Future<bool> isActive() async {
    try{
      String loaded = await storage.read(key: "active")??"false";
      if(loaded=="false"){
        return false;
      }
      return true;
    }catch(e){
      return false;
    }

  }
  static saveActive(bool val) async {
    storage.write(key: "active",value: val.toString());
  }

  /// logout
  static logout() async {
    await storage.delete(key: "active");
    await storage.delete(key: "loginInfo");
    API.is_active = false;
    API.email = "";
    API.password = "";
    API.customer_id = -1;
    Get.offAll(() => HomeScreen());
  }


}