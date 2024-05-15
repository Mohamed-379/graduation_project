import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper
{
  static String? id;
  static String? name;
  static String? email;
  static bool? isPremium = false;
  static late SharedPreferences sharedPreferences;

  static Future<void> cacheInitialization() async
  {
   sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setUserId(String id) async{
    sharedPreferences.setString("id", id);
  }

  static Future<void> setUserName(String name) async{
    await sharedPreferences.setString("name", name);
  }

  static Future<void> setUserEmail(String email) async{
    await sharedPreferences.setString("email", email);
  }

  static Future<void> setUserIsPremium(bool isPremium) async{
    await sharedPreferences.setBool("isPremium", isPremium);
  }

  static String? getUserEmail() {
    return sharedPreferences.getString("email");
  }

  static String? getUserName() {
    return sharedPreferences.getString("name");
  }

  static String? getUserId() {
    return sharedPreferences.getString("id");
  }

  static bool? getUserIsPremium() {
    return sharedPreferences.getBool("isPremium");
  }

  static void deleteUserInfo({required String key}) {
    sharedPreferences.remove(key);
  }

  static void deleteUserId() {
    sharedPreferences.remove("id");
  }

  static void deleteUserEmail() {
    sharedPreferences.remove("email");
  }

  static void deleteUserName() {
    sharedPreferences.remove("name");
  }

  static void deleteUserIsPremium() {
    sharedPreferences.remove("isPremium");
  }
}