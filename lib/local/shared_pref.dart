import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setEmail(String email) async{
    await sharedPreferences!.setString("email", email);
  }

  static String? getEmail(){
    return sharedPreferences!.getString("email");
  }

  static Future<void> setPassword(String pass) async{
    await sharedPreferences!.setString("password", pass);
  }

  static String? getPassword(){
    return sharedPreferences!.getString("password");
  }
}