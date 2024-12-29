import 'package:flutter/material.dart';
import 'package:todo_note_app/src/controller/theme_controller.dart';

class ThemeDataProvider extends ChangeNotifier {
  bool isDark = false;

  ThemeDataProvider() {
    _loadThemeState();
  }

  void _loadThemeState() async {
    isDark = await ThemeController.loadDarkThemeState();
    notifyListeners();
  }

  void toggleTheme() async {
    isDark = !isDark;
    await ThemeController.saveDarkThemeState(isDark);
    notifyListeners();
  }
}
