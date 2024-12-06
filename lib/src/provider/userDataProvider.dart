import 'package:flutter/material.dart';
import 'package:my_todo_app/src/controller/token_controller.dart';

class UserDataPovider extends ChangeNotifier {
  bool dataLoaded = false;
  String name = "";
  String email = "";
  String userId = "";
  getUserData(Future fetch, context, nextPage) async {
    try {
      final data = await fetch;
      print(data);

      if (data["error"] == "Please authenticate") {
        TokenController.token = "";
        // notifyListeners();
        // await Token.saveToken(Token.token);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data["error"])));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
            ));
      } else {
        name = data["name"].toString();
        email = data["email"].toString();
        userId = data["_id"].toString();
        print(userId);
        dataLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      dataLoaded = false;
      notifyListeners();
    }
  }
}
