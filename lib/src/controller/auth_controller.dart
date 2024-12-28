import 'dart:convert';

import 'package:todo_note_app/src/constant/api.dart';
import 'package:todo_note_app/src/model/UserSignInModel.dart';
import 'package:todo_note_app/src/model/userSignUpModel.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<Map<String, dynamic>> signUp(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse(signUpUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return {'success': true, 'token': data['token']};
      } else {
        return {'success': false, 'message': 'Sign-up failed'};
      }
    } catch (e) {
      return {'error': 'Error signing up: $e'};
    }
  }

  Future<Map<String, dynamic>> signIn(UserSignInModel user) async {
    try {
      final response = await http.post(
        Uri.parse(signInUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'token': data['token']};
      } else {
        return {'success': false, 'message': 'Sign-in failed'};
      }
    } catch (e) {
      return {'error': 'Error signing in: $e'};
    }
  }

  Future fetchUserData(String _token) async {
    try {
      final response = await http.get(
        Uri.parse(userProfileUrl),
        headers: {
          'Authorization': 'Bearer ${_token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to load user data: ${response.body}');
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Exception occurred while fetching user data: $e');
    }
  }
}
