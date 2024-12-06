import 'package:flutter/material.dart';
import 'package:my_todo_app/src/controller/token_controller.dart';
import 'package:my_todo_app/src/provider/bottomBarToggle.dart';
import 'package:my_todo_app/src/provider/themeDataProvider.dart';
import 'package:my_todo_app/src/provider/todo_provider.dart';
import 'package:my_todo_app/src/provider/userDataProvider.dart';
import 'package:my_todo_app/src/view/auth_view/signUpPage.dart';
import 'package:my_todo_app/src/view/main_view/homePage.dart';
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TokenController.token = await TokenController().loadToken();
  // ThemeDataProvider().isDark = await ThemeController.loadDarkThemeState();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserDataPovider(),
      ),
      ChangeNotifierProvider(
        create: (context) => BottomBarToggle(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TodoProvider(),
      ),
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
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: darkTheme,
      home: TokenController.token == ""
          ? SignUpPage()
          : HomePage(token: TokenController.token),
    );
  }
}
