import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  Future<void> _checkAuth(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    print("Token fetched from SharedPreferences: $token");
    if (token.isEmpty) {
      Navigator.popAndPushNamed(context, '/signin');
    } else {
      Navigator.popAndPushNamed(context, '/home', arguments: token);
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAuth(context);
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
