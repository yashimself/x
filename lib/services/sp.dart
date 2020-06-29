import 'package:shared_preferences/shared_preferences.dart';


class Sp{
  static String userloggedinspkey = "ISLOGGEDIN";
  static String spusernamekey = "USERNAMEKEY";
  static String spuseremailkey = "USEREMAILKEY";
  static String useremailverificationkey = "ISVERIFIED";

  //userloggedin

  static Future<bool> saveUserLoggedinpreference(bool toggle) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(userloggedinspkey, toggle);
  }


  //Username

  static Future<bool> saveUsernamesharedpreference(String userName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(spusernamekey, userName);
  }

  //UserEmail

  static Future<bool> saveUserEmailsharedpreference(String userEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(spuseremailkey, userEmail);
  }

  static Future<bool> saveuseremailverificationpreference(bool toggle) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(useremailverificationkey, toggle);
  }

  //****************Data retrieval****************

  static Future<bool> getUserLoggedinpreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(userloggedinspkey);
  }

  static Future<String> getUsernamesharedpreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(spusernamekey);
  }

  static Future<String> getUserEmailsharedpreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(spuseremailkey);
  }

  static Future<bool> getuseremailverificationpreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(useremailverificationkey);
  }


}