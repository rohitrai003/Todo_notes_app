import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider with ChangeNotifier {
  String? token;
  String _tokenName = "token";
  Future<void> loadToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString(_tokenName) ?? '';
    print('Loaded token: $token');
    notifyListeners();
  }

  Future<void> saveToken(String newToken) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_tokenName, newToken);
    token = newToken;
    notifyListeners();
  }

  Future<void> clearToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(_tokenName);
    token = '';
    notifyListeners();
  }
}
