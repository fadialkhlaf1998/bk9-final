import 'package:shared_preferences/shared_preferences.dart';


class Store {

  static bool introScreenValue = false;

  static saveIntroScreen(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("value", value);
  }

  static Future loadIntroScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool stringValue = prefs.getBool("value") ?? false;
    return stringValue;
  }

}