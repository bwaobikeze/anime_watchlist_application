import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static late SharedPreferences _preferences;
    static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

   static SharedPreferences get instance => _preferences;
}
