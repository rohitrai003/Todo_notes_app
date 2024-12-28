import 'package:flutter/material.dart';
import 'package:todo_note_app/src/controller/theme_controller.dart';

class ThemeDataProvider extends ChangeNotifier {
  bool isDark = false;

  toggleTheme(context) {
    isDark = !isDark;
    print("Theme (Is Dark): ${isDark}");
    ThemeController.saveDarkThemeState(context);
    notifyListeners();
  }
}
