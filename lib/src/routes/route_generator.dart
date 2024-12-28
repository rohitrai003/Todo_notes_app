import 'package:flutter/material.dart';
import 'package:todo_note_app/src/view/auth_view/signInPage.dart';
import 'package:todo_note_app/src/view/auth_view/signUpPage.dart';
import 'package:todo_note_app/src/view/main_view/homePage.dart';
import 'package:todo_note_app/src/view/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/home':
        final token = settings.arguments as String?;
        if (token != null && token.isNotEmpty) {
          return MaterialPageRoute(
            builder: (_) => HomePage(token: token),
          );
        }
        return _errorRoute();
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR: Route not found!'),
        ),
      );
    });
  }
}
