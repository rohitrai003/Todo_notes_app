import 'package:flutter/material.dart';
import 'package:my_todo_app/src/controller/auth_controller.dart';

class UserDataProvider extends ChangeNotifier {
  bool dataLoading = false;
  final Map<String, dynamic> userDetails = {};

  getUserData(String token) async {
    dataLoading = true;
    notifyListeners();

    final _data = await AuthController().fetchUserData(token);

    userDetails.addAll(_data);
    print(userDetails);
    dataLoading = false;
    notifyListeners();
  }
}
