import "package:shared_preferences/shared_preferences.dart";

class TokenController {
  static String token = "fdsf";
  static const _key = "token";

  Future saveToken(String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(_key, value);
    return {"message": 'Saved Successfully'};
  }

  Future<String> loadToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_key) as String;
  }
}
