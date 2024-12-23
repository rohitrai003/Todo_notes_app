import 'package:flutter/material.dart';
import 'package:my_todo_app/src/provider/authProvider.dart';
import 'package:my_todo_app/src/provider/bottomBarToggle.dart';
import 'package:my_todo_app/src/provider/themeDataProvider.dart';
import 'package:my_todo_app/src/provider/todo_provider.dart';
import 'package:my_todo_app/src/provider/token_provider.dart';
import 'package:my_todo_app/src/provider/userDataProvider.dart';
import 'package:my_todo_app/src/routes/route_generator.dart';
import 'package:my_todo_app/src/view/splash_screen.dart';
import "package:provider/provider.dart";

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserDataProvider()),
      ChangeNotifierProvider(create: (context) => BottomBarToggle()),
      ChangeNotifierProvider(create: (context) => ThemeDataProvider()),
      ChangeNotifierProvider(create: (context) => TodoProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => TokenProvider()),
    ],
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: SplashScreen());
  }
}
