import "package:todo_note_app/src/provider/themeDataProvider.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeController {
  static Future<void> saveDarkThemeState(bool isDark) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setBool("isDark", isDark);
      print("Saved isDark: $isDark");
    } catch (e) {
      print("Error saving theme state: $e");
    }
  }

  static Future<bool> loadDarkThemeState() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool("isDark") ?? false;
    } catch (e) {
      print("Error loading theme state: $e");
      return false;
    }
  }
}
