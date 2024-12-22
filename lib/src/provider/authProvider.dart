import 'package:flutter/material.dart';
import 'package:my_todo_app/src/model/UserSignInModel.dart';
import 'package:my_todo_app/src/provider/token_provider.dart';
import 'package:my_todo_app/src/view/main_view/homePage.dart';

import '../controller/auth_controller.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserSignInModel user = UserSignInModel(
        email: email,
        password: password,
      );
      final data = await AuthController().signIn(user);
      final String token = data['token'];
      print(data);

      if (token.isNotEmpty) {
        final tokenProvider = TokenProvider();
        await tokenProvider.saveToken(token);
        print("TOKEN" + TokenProvider().token.toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    token: token,
                  )),
        );
      } else {
        _showError("Invalid email or password", context);
      }
    } catch (e) {
      print(e);
      _showError("An error occurred. Please try again.", context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showError(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
