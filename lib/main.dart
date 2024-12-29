import 'package:flutter/material.dart';
import 'package:todo_note_app/src/provider/authProvider.dart';
import 'package:todo_note_app/src/provider/bottomBarToggle.dart';
import 'package:todo_note_app/src/provider/themeDataProvider.dart';
import 'package:todo_note_app/src/provider/todo_provider.dart';
import 'package:todo_note_app/src/provider/token_provider.dart';
import 'package:todo_note_app/src/provider/userDataProvider.dart';
import 'package:todo_note_app/src/routes/route_generator.dart';
import 'package:todo_note_app/src/view/splash_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: SplashScreen());
  }
}
