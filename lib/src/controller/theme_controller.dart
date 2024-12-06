import "package:my_todo_app/src/provider/themeDataProvider.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeController {
  static Future saveDarkThemeState(context) async {
    final themeProvider =
        Provider.of<ThemeDataProvider>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool("isDark", themeProvider.isDark);
  }

  static Future<bool> loadDarkThemeState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("isDark") ?? false;
  }
}
